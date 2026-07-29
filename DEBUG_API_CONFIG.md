# API Configuration Debug Report

## Problem
Runtime error: `Failed host lookup: 'your_api_base_url'`

This indicates that Dio is receiving a string that is literally "your_api_base_url" instead of the actual URL.

## Investigation

### 1. AppConfig Setup
- ✅ `lib/core/config/app_config.dart` has correct URLs
- ✅ Development: `http://159.69.54.76:3000/api`
- ✅ Staging: `https://staging-api.jobmap.app/api`
- ✅ Production: `https://api.jobmap.app/api`

### 2. Initialization Flow
- ✅ `main.dart` calls `AppConfig.init(Environment.development)`
- ✅ Service Locator calls `AppConfig.fullApiUrl` to create Dio
- ✅ All remote datasources use relative paths (e.g., `/auth/login`)

### 3. Search Results
- ✅ NO occurrences of `your_api_base_url` found in project
- ✅ NO other hardcoded localhost URLs
- ✅ NO direct Dio instantiation (only via DioProvider)

## Hypotheses

### Hypothesis 1: Getter Not Called
The error message `'your_api_base_url'` looks like:
- A placeholder string
- A property name instead of value
- A getter that wasn't evaluated

Possible causes:
- `AppConfig.fullApiUrl` property wasn't accessed
- String interpolation failed
- `apiBaseUrl` getter returned something unexpected

### Hypothesis 2: Environment Enum Issue
Check if:
- `AppConfig.environment` is null
- `_environment` wasn't set properly
- `_getConfig(env)` returned wrong config

### Hypothesis 3: Dart String Interpolation Issue
The string `'$apiBaseUrl/$apiVersion'` should become `'http://159.69.54.76:3000/api/v1'`

If it shows as `'your_api_base_url'`, then something in the interpolation failed.

## Debug Output Added
Added debug prints to:
1. `AppConfig.init()` - Prints environment, base URL, full URL
2. `DioProvider.createDio()` - Prints the baseUrl being set

## Next Steps

1. Run the app and check console for:
   ```
   🔧 AppConfig Initialized
   Environment: Environment.development
   API Base URL: http://159.69.54.76:3000/api
   API Version: v1
   Full API URL: http://159.69.54.76:3000/api/v1
   
   🌐 DioProvider.createDio()
   Base URL: http://159.69.54.76:3000/api/v1
   Enable Logging: true
   ```

2. If prints show correct URLs, then error is from API calls, not Dio setup

3. If prints show `'your_api_base_url'`, then check:
   - AppConfig._environment initialization
   - AppConfig._config initialization
   - String interpolation in fullApiUrl getter

## Possible Root Causes

1. **AppConfig not initialized** - If `AppConfig.init()` wasn't called, `_environment` remains uninitialized
2. **Service Locator called before AppConfig.init()** - Order matters
3. **Lazy singleton issue** - Dio might be created before AppConfig is ready
4. **Environment variable override** - Check if any environment variables override the config
5. **String formatting issue** - The `'$apiBaseUrl/$apiVersion'` interpolation
6. **Code generation issue** - If using build_runner, might need to regenerate
