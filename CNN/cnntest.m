function [er, bad] = cnntest(net, x, y)
%  feedforward
% 测试网络时对当前网络进行前向传播即可得到结果
net = cnnff(net, x);% 前向传播得到输出
[~, h] = max(net.o);% 找到最大的输出对应的标签
[~, a] = max(y); % 找到最大的期望输出对应的索引
bad = find(h ~= a);% 找到他们不相同的个数，也就是错误的次数
er = numel(bad) / size(y, 2); % 计算错误率
end
