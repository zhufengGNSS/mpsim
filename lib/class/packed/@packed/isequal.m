function answer = isequal (varargin)
    answer = isequal2 ('isequal', varargin{:});
end

%!error
%! lasterr('', '');
%! isequal(packed);

%!test
%! % isequal ()
%! s = lasterror;
%! myassert (s.identifier, 'packed:isequal:notEnoughInputs');

%!test
%! myassert (isequal(packed([]), packed([])))

%!test
%! myassert (isequal(eye(2), eye(2), packed(eye(2)), eye(2), packed(eye(2)), eye(2), eye(2)));

%!test
%! n = 10;
%! for i=1:3
%!     temp = randsym(n);
%!     switch i
%!     case 1
%!         A_full = temp;
%!         A = packed(A_full);
%!         B = A;
%!         myassert (ispacked(A));
%!         j = i;
%!     case 2
%!         A_full = temp;
%!         A = packed(A_full(triu(true(n))), 'sym', 'u');
%!         B = packed(A_full(tril(true(n))), 'sym', 'l');
%!         myassert (ispacked(A));
%!         myassert (ispacked(B));
%!         j = i;
%!     case 3
%!         % make it the same value in either precision:
%!         A_full = double(single(temp));
%!         A = packed(cast(A_full, 'double'));
%!         B = packed(cast(A_full, 'single'));
%!         myassert (ispacked(A));
%!         myassert (ispacked(B));
%!         myassert (isa(A, 'double'));
%!         myassert (isa(B, 'single'));
%!         j = i;
%!     end
%! 
%!     myassert (isequal (A, A));
%! 
%!     myassert (isequal (A, B));
%!     myassert (isequal (B, A));
%! 
%!     myassert (isequal (A, A_full));
%!     myassert (isequal (A_full, A));
%!     myassert (~isequal (-A_full, A));
%! 
%!     myassert (isequal (A_full, A_full, A));
%!     myassert (isequal (A, A, A_full));
%!     myassert (isequal (A, A_full, A));
%! end
%! myassert (j, i);

%!shared
%! while true
%!     n = round(10*rand);
%!     if (n > 1),  break;  end
%! end
%! value = rand;
%! A_full = value .* eye(n);
%! 
%! idx = triu(true(n));
%! A_pkd_sym_u = packed(A_full(idx), 'sym', 'u');
%! 
%! idx = tril(true(n));
%! A_pkd_sym_l = packed(A_full(idx), 'sym', 'l');
%! 
%! idx = triu(true(n));
%! A_pkd_tri_u = packed(A_full(idx), 'tri', 'u');
%! 
%! idx = tril(true(n));
%! A_pkd_tri_l = packed(A_full(idx), 'sym', 'l');
%! 
%! %keyboard  % DEBUG

%!test
%! myassert(isequal(A_pkd_sym_u, A_pkd_sym_u));

%!test
%! myassert(isequal(A_pkd_sym_u, A_pkd_sym_l));

%!test
%! myassert(isequal(A_pkd_sym_u, A_pkd_tri_u));

%!test
%! myassert(isequal(A_pkd_sym_u, A_pkd_tri_l));

%!shared  % (just to clear previous %!shared)

