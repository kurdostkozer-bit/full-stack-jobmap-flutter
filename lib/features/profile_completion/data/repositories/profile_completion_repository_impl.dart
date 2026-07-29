import '../../domain/entities/profile_completion_entities.dart';
import '../../domain/repositories/profile_completion_repository.dart';

class ProfileCompletionRepositoryImpl implements ProfileCompletionRepository {
  // Local calculation based on available data
  @override
  Future<ProfileCompletionEntity> calculateProfileCompletion(
    String careerProfileId,
  ) async {
    // Simple calculation algorithm
    final sectionsCompleted = <String, bool>{
      CompletionSection.basicInfo.value: true, // Basic info always considered complete
      CompletionSection.education.value: false,
      CompletionSection.experience.value: false,
      CompletionSection.skills.value: false,
      CompletionSection.projects.value: false,
      CompletionSection.languages.value: false,
      CompletionSection.certificates.value: false,
      CompletionSection.attachments.value: false,
      CompletionSection.socialLinks.value: false,
      CompletionSection.jobPreferences.value: false,
    };

    // Calculate percentage: 1 (basic) out of 10 sections = 10%
    final completedCount = sectionsCompleted.values.where((v) => v).length;
    final totalSections = sectionsCompleted.length;
    final completionPercentage = ((completedCount / totalSections) * 100).toInt();

    return ProfileCompletionEntity(
      careerProfileId: careerProfileId,
      completionPercentage: completionPercentage,
      sectionsCompleted: sectionsCompleted,
      nextSteps: _calculateNextSteps(sectionsCompleted),
      lastUpdated: DateTime.now(),
    );
  }

  @override
  Future<ProfileCompletionEntity?> getProfileCompletion(
    String careerProfileId,
  ) async {
    // In a real scenario, this would fetch from backend or cache
    return await calculateProfileCompletion(careerProfileId);
  }

  @override
  Future<void> updateSectionCompletion(
    String careerProfileId,
    CompletionSection section,
    bool isCompleted,
  ) async {
    // In a real scenario, this would save to backend
    // For now, just a placeholder
  }

  @override
  Future<List<String>> getNextSteps(String careerProfileId) async {
    final completion = await calculateProfileCompletion(careerProfileId);
    return completion.nextSteps;
  }

  List<String> _calculateNextSteps(Map<String, bool> sections) {
    final nextSteps = <String>[];

    if (!sections[CompletionSection.education.value]!) {
      nextSteps.add('Add your education history');
    }
    if (!sections[CompletionSection.experience.value]!) {
      nextSteps.add('Add your work experience');
    }
    if (!sections[CompletionSection.skills.value]!) {
      nextSteps.add('Add your skills');
    }
    if (!sections[CompletionSection.projects.value]!) {
      nextSteps.add('Add your projects');
    }
    if (!sections[CompletionSection.certificates.value]!) {
      nextSteps.add('Add your certificates');
    }
    if (!sections[CompletionSection.attachments.value]!) {
      nextSteps.add('Upload your resume');
    }
    if (!sections[CompletionSection.jobPreferences.value]!) {
      nextSteps.add('Set your job preferences');
    }

    return nextSteps;
  }
}
