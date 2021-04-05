function d = damageelasticity(e, aggregateq)
da = (aggregateq/100).^e;
for i=1:12
    da(:,i) = da(:,i)/sum(da(:,i));
end
d = da*100;
