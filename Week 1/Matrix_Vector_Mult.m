%% Make random matrix (300 X 300) and vector (300 X 1)
A = rand(300);
x = rand(300,1);

%% matvec speed test
tic;
for i = 1:100
    matvec(A,x);
end
toc;

% matvec2_row speed test
tic;
for i = 1:100
    matvec2_row(A,x);
end
toc;

% matcec2_col speed text
tic;
for i = 1:100
    matvec2_col(A,x);
end
toc;

%% Testing matrix multiplication algorithms
A = rand(3,5);
B = rand(5,2);

C = inner_prod(A,B)
C = outer_prod(A,B)
answer = A*B

%% Problems to Ponder 3 - implement multiplications in order with least FLOPS
A = rand(4,4);
u = A(:,1);
v = A(:,2);
x = A(:,3);
y = A(:,4);
D = [1 0 0 0; 0 5 0 0; 0 0 8 0; 0 0 0 4];

% u*(v^tA)
outer_prod(u,outer_prod(v',A))
answer = u*(v'*A)

% (Au)*(v^tB)
outer_prod(matvec2_col(A,u),outer_prod(v',A))
answer = (A*u)*(v'*A)

% A*(Dx)
outer_prod(A,matvec2_col(D,x))
answer = A*(D*x)

%% Tridiagnal matrix
test = [1 3 5 2 3];
y = T(test)

%% FUNCTIONS
function y = matvec(A,x)
    % Simple matrix vector multiplication
    % Form y = A*x (version 1)
    
    [m,n] = size(A);
    y = zeros(m,1);
    for i = 1:m
        for j = 1:n
            y(i) = y(i) + A(i,j)*x(j);
        end
    end
end

function y = matvec2_row(A,x)
    % Dots each matrix row with vector
    % Form y = A*x (row-oriented)
    
    [m,n] = size(A);
    y = zeros(m,1);
    for i = 1:m
        y(i) = A(i,:)*x;
    end
end

function y = matvec2_col(A,x)
    % Scale each column of matrix by nth
    % Element of the vector
    % Form y = A*x (column-oriented)
    
    [m,n] = size(A);
    y = zeros(m,1);
    for j = 1:n
        y = y + A(:,j)*x(j);
    end
end

function C = inner_prod(A,B)
    % Inner product variant of matrix
    % Multiplication
    
    m = size(A, 1);
    n = size(B, 2);
    C = zeros(m,n);
    
    for i = 1:m
        for j = 1:n
            C(i,j) = C(i,j) + A(i,:)*B(:,j);
        end
    end
end

function C = outer_prod(A,B)
    % Outer product variant of matrix
    % Multiplication
    
    [m,p] = size(A);
    [p,n] = size(B);
    C = zeros(m,n);
    
    for k = 1:p
        % Add in k-th outer product
        C = C + A(:,k)*B(k,:);
    end
end

function y = T(vec)
    y = zeros(1,length(vec));
    for i = 1:length(vec)
        if (i == 1)
            y(i) = -0 + 2*vec(i) - vec(i+1);
        elseif (i == length(vec))
            y(i) = vec(i-1) + 2*vec(i) - 0;
        else
            y(i) = vec(i-1) + 2*vec(i) + vec(i+1);
        end
    end
end
