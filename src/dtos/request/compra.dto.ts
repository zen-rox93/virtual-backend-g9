import { Type } from "class-transformer";
import { IsArray, IsNumber, IsPositive, ValidateNested, IsUUID } from "class-validator"

class DetalleCompraDto{
    @IsUUID("4")
    producto: number;

    @IsNumber()
    @IsPositive()
    cantidad: number;
}

export class CompraDto {
    @IsArray()
    @ValidateNested({ each: true })
    @Type(() => DetalleCompraDto)
    detalle: DetalleCompraDto[];
}