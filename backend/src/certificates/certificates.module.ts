import { Module } from '@nestjs/common';

import { CertificatesController } from './controllers/certificates.controller';
import { CertificatesRepository } from './repositories/certificates.repository';
import { CertificatesService } from './services/certificates.service';

@Module({
  controllers: [CertificatesController],
  providers: [CertificatesService, CertificatesRepository],
  exports: [CertificatesService],
})
export class CertificatesModule {}
