# Test qubit Clifford algebra relations
@testset "Qubit Clifford relations" begin
    @test comm(q('x'),q('y')) == 2*im*q('z')
    @test comm(q('y'),q('z')) == 2*im*q('x')
    @test comm(q('z'),q('x')) == 2*im*q('y')
    @test acomm(q('x'),q('y')) == spzeros(QComp,q.dim,q.dim)
    @test acomm(q('y'),q('z')) == spzeros(QComp,q.dim,q.dim)
    @test acomm(q('z'),q('x')) == spzeros(QComp,q.dim,q.dim)
    @test acomm(q('x'),q('x')) == 2*q('i')
    @test acomm(q('y'),q('y')) == 2*q('i')
    @test acomm(q('z'),q('z')) == 2*q('i')
    @test acomm(q('x'),q('y')) == spzeros(QComp,q.dim,q.dim)
    @test acomm(q('y'),q('z')) == spzeros(QComp,q.dim,q.dim)
    @test acomm(q('z'),q('x')) == spzeros(QComp,q.dim,q.dim)
end

# Test superpositions and bra
xplus = (q[1] + q[2])/sqrt(2)
xplus2 = (q(0) + q(1))/sqrt(2)
@test xplus == xplus2
@test bra(xplus)(xplus) ≈ dot(xplus,xplus)
yplus = (q[1] + im*q[2])/sqrt(2)

# Test transition operator
xtoy = transition(yplus, xplus)
@test tr(xtoy) ≈ dot(xplus, yplus)

# Test expectations and weak values
@test weakvaluevec(xplus, yplus, q('z')) == QComp(-im)
xplusp = projector(xplus)
yplusp = projector(yplus)
@test weakvalue(xplusp, yplusp, q('z')) == QComp(-im)
