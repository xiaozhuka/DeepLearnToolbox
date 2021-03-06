function net = cnntrain(net, x, y, opts)
% m保存的是训练样本个数
m = size(x, 3);
% 打包个数，也就是每隔batchsize更新一次权重必须为整数
numbatches = m / opts.batchsize;
if rem(numbatches, 1) ~= 0
    error('numbatches not integer');
end
net.rL = [];
% numepochs为训练次数
for i = 1 : opts.numepochs
    disp(['epoch ' num2str(i) '/' num2str(opts.numepochs)]);
    tic;
    % P = randperm(N) 返回[1, N]之间所有整数的一个随机的序列，例如  
    % randperm(6) 可能会返回 [2 4 5 6 1 3]  
    % 这样就相当于把原来的样本排列打乱，再挑出一些样本来训练
    kk = randperm(m);
    % 去除打乱顺序后的numbatches*batchsize个训练样本参与训练
    for l = 1 : numbatches
        % 取得batchsize个训练样本 
        batch_x = x(:, :, kk((l - 1) * opts.batchsize + 1 : l * opts.batchsize));
        batch_y = y(:,    kk((l - 1) * opts.batchsize + 1 : l * opts.batchsize));
        % 在当前的网络权值和网络输入下计算网络的输出  
        net = cnnff(net, batch_x);%feedforword
        % 得到上面的网络输出后，通过对应的样本标签用bp算法来得到误差对网络权值  
        %（也就是那些卷积核的元素）的导数 
        net = cnnbp(net, batch_y);%backpropagation
        % 得到误差对权值的导数后，就通过权值更新方法去更新权值
        net = cnnapplygrads(net, opts);
        if isempty(net.rL)
            net.rL(1) = net.L;%误差值或代价函数值
        end
        % 保存历史的误差值，以便画图分析？ 
        net.rL(end + 1) = 0.99 * net.rL(end) + 0.01 * net.L;
    end
    toc;
end

end
