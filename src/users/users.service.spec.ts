import { Test, TestingModule } from '@nestjs/testing';
import { CreateUserDto } from './dto/create-user.dto';
import { UsersService } from './users.service';

describe('UsersService', () => {
  let service: UsersService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [UsersService],
    }).compile();

    service = module.get<UsersService>(UsersService);
  });

  describe('CREATE', () => {
    it('should be defined', () => {
      expect(service).toBeDefined();
    });

    it('Create user', async () => {
      const createUserDto = new CreateUserDto()
      createUserDto.name = 'Gabriel Casas'
      createUserDto.cardId = '9999999'
      createUserDto.bornDate = '24/10/1993'
      const resultUser = await service.create(createUserDto)
      expect(resultUser.id).toBeGreaterThan(0);

    });
    it('Create user', async () => {
      const resultUser = await service.findAll()
      console.log(resultUser)
      expect(resultUser.datos.length).toBeGreaterThan(0);

    });
  })
});
