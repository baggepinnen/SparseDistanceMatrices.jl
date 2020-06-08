using SparseDistanceMatrices

using Test

@testset "SparseDistanceMatrices" begin

    N = 100
    Ts = [Int16, Int32, Int64, Float16, Float32, Float64]

    for T in Ts
        D = SparseDistanceMatrix(N, Int[], Int[], T[])
        a = T <: Integer ? trunc(T, 10.0) : T(10.0)
        b = T <: Integer ? trunc(T, 12.3) : T(12.3)
        D[1,20] = a
        D[40,2] = b

        @test size(D) == (100, 100)
        @test D[1,1] == typemax(T)
        @test D[1,100] == typemax(T)
        @test D[1,20] == a
        @test D[40,2] == b
        @test D != D'
        @test symmetrize!(D) == D'
    end

end
