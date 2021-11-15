%Nichole Etienne 
%BMI 500 
%PC1
% guidance : https://www.mathworks.com/help/stats/pca.html


function outcome = pc1(filtered)
coeff = pca(filtered);
outcome=filtered * coeff(:,1);