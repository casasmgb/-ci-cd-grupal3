import { Injectable } from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';

@Injectable()
export class UsersService {
  id: number = 0
  newUser = new CreateUserDto()
  create(createUserDto: CreateUserDto) {
    this.newUser = createUserDto
    this.newUser.id = this.id+1
    return this.newUser;
  }

  findAll() {
    const datos = []
    for (let i = 1; i < 6; i++) {
      this.newUser.id = i
      this.newUser.name = `Usuario - ${i}`
      this.newUser.cardId = `999999-${i}`
      this.newUser.bornDate = `2${i}/10/1998`
      datos.push(this.newUser)
    }
    return {
      datos
    };
  }

  findOne(id: number) {
    return `This action returns a #${id} user`;
  }

  update(id: number, updateUserDto: UpdateUserDto) {
    return `This action updates a #${id} user`;
  }

  remove(id: number) {
    return `This action removes a #${id} user`;
  }
}
