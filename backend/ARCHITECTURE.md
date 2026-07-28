# JobMap Backend Architecture

Status: Foundation

Layers:

- Config
- Database
- Common
- Modules
- Shared

Architecture Style:

- Modular Monolith
- Clean Architecture
- Domain Driven Design (DDD)

Rules:

- No business logic inside controllers.
- Services orchestrate use cases only.
- Database access goes through repositories.
- DTOs are used only in the presentation layer.
- Domain models must not depend on NestJS.