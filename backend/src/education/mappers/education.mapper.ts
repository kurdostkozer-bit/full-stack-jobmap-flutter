import { EducationEntity } from '../entities/education.entity';
import { EducationResponseDto } from '../dto/education-response.dto';

export class EducationMapper {
  static toResponse(education: EducationEntity): EducationResponseDto {
    return {
      id: education.id,
      careerProfileId: education.careerProfileId,
      institution: education.institution,
      college: education.college,
      degree: education.degree,
      fieldOfStudy: education.fieldOfStudy,
      grade: education.grade,
      gradeType: education.gradeType,
      country: education.country,
      city: education.city,
      description: education.description,
      startDate: education.startDate,
      endDate: education.endDate,
      isCurrent: education.isCurrent,
      createdAt: education.createdAt,
      updatedAt: education.updatedAt,
    };
  }
}
