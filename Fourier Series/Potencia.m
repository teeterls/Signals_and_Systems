function P = Potencia(x,dt,T)
y=x;
for i=1:length(x)
    y(i)=(abs(y(i)))^2;
end
P=0;
for i=1:T/dt
    P=P+(dt*y(i));
end
P=P/(T);
end

