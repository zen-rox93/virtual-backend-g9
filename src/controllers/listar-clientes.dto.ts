import { IsNumber, IsOptional, IsPositive } from "class-validator";
import { BaseDto } from "../dtos/base.dto";

export class listarClienteDto extends BaseDto{
    @IsOptional()
    @IsNumber()
    @IsPositive()
    page: number;

    @IsOptional()
    @IsNumber()
    @IsPositive()
    perPage: number;


} 