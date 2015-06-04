function total=saving(p, r, n, mode)
% load: �ھڨC���������B�A�p������`�ȡ]�δ����`�ȡ^
%
%	Usage: total=saving(p, r, n, mode)
%		p: �C���J���B
%		r: �~�Q�v
%		n: �`�~��
%		mode: 'initial' for �����`���B, 'final' for �����`���B
%		total: �`���B�A������δ���
%
%	Description:
%		saving is the inverse function of loan:
%			saving(loan(total, r, n), r, n, 'initial') returns total.
%			loan(saving(p, r, n, 'initial'), r, n) returns p.
%
%	Example:
%		p=1000;
%		r=3/100;
%		n=20;
%		ti=saving(p, r, n, 'initial');
%		tf=saving(p, r, n, 'final');
%		fprintf('�C���J=%g��, �Q�v=%.2f%%, ����=%d�~, �����`�B=%.2f�U, �����`�B=%.2f�U\n', p, r*100, n, ti/10000, tf/10000);
%
%	See also loan.

%	Roger Jang, 20110709

if nargin<1, selfdemo; return; end
if nargin<4, mode='final'; end

finalTotalValue=p*((1+r/12)^(12*n)-1)/(r/12);	% Compute the final total value
switch(mode)
	case 'initial'
		total=finalTotalValue/((1+r/12)^(12*n));
	case 'final'
		total=finalTotalValue;
	otherwise
		error('Unknown mode=%s', mode);
end

% ====== Self demo
function selfdemo
mObj=mFileParse(which(mfilename));
strEval(mObj.example);