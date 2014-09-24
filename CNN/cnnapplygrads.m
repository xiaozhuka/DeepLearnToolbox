function net = cnnapplygrads(net, opts)
% 更新权值
for l = 2 : numel(net.layers)
    % 只更新卷积层的权值，为什么子采样层不更新呢？
    if strcmp(net.layers{l}.type, 'c')
        for j = 1 : numel(net.layers{l}.a)
            for ii = 1 : numel(net.layers{l - 1}.a)
                % 普通的权值更新的公式：W_new = W_old - alpha * de/dW（误差对权值导数） 
                net.layers{l}.k{ii}{j} = net.layers{l}.k{ii}{j} - opts.alpha * net.layers{l}.dk{ii}{j};
            end
            net.layers{l}.b{j} = net.layers{l}.b{j} - opts.alpha * net.layers{l}.db{j};
        end
    end
end

net.ffW = net.ffW - opts.alpha * net.dffW;
net.ffb = net.ffb - opts.alpha * net.dffb;
end
