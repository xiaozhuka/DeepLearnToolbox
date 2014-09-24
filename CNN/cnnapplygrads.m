function net = cnnapplygrads(net, opts)
% ����Ȩֵ
for l = 2 : numel(net.layers)
    % ֻ���¾�����Ȩֵ��Ϊʲô�Ӳ����㲻�����أ�
    if strcmp(net.layers{l}.type, 'c')
        for j = 1 : numel(net.layers{l}.a)
            for ii = 1 : numel(net.layers{l - 1}.a)
                % ��ͨ��Ȩֵ���µĹ�ʽ��W_new = W_old - alpha * de/dW������Ȩֵ������ 
                net.layers{l}.k{ii}{j} = net.layers{l}.k{ii}{j} - opts.alpha * net.layers{l}.dk{ii}{j};
            end
            net.layers{l}.b{j} = net.layers{l}.b{j} - opts.alpha * net.layers{l}.db{j};
        end
    end
end

net.ffW = net.ffW - opts.alpha * net.dffW;
net.ffb = net.ffb - opts.alpha * net.dffb;
end
