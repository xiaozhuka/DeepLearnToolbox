function [er, bad] = cnntest(net, x, y)
%  feedforward
% ��������ʱ�Ե�ǰ�������ǰ�򴫲����ɵõ����
net = cnnff(net, x);% ǰ�򴫲��õ����
[~, h] = max(net.o);% �ҵ����������Ӧ�ı�ǩ
[~, a] = max(y); % �ҵ��������������Ӧ������
bad = find(h ~= a);% �ҵ����ǲ���ͬ�ĸ�����Ҳ���Ǵ���Ĵ���
er = numel(bad) / size(y, 2); % ���������
end
