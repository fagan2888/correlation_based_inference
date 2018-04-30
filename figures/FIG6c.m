% Figure 8 - AUC results for eLSA and SparCC.

clear;
fig_setup;
load('data/results_main/analysis_setup');

AB = {'C)','D)'};
jID = [4 3; 2 1];

xi = [2*fL+dL, L+dL, L+dL, L+2*dL+4*fL, L+dL, L+dL];
yi = [2*fL+dL, L+2*dL+2*fL];
xpos = cumsum(xi);
ypos = cumsum(yi);
totwidth = xpos(end)+L+dL;
totheight = ypos(end)+L+dL+fL;

figure('Units','centimeters','Position',[10 10 totwidth totheight]);
make_ax = @(i,j) axes('Units','centimeters','Position',[xpos(i),ypos(j),L,L]);
add_label = @(str) text(-.4,1.1,str,'FontSize',Fs,'FontWeight','bold');

for m = 1:length(M)
    for s = 1:length(S)
        for n = 1:length(N)
            load(sprintf('data/networks/S%d_N%d',s,n));
            load(sprintf('data/results_main/%s_S%d_N%d',M{m},s,n));
            make_ax(n+(m-1)*3,3-s);
            plot([0 1],[.5 .5],'--','Color',[.5 .5 .5],'LineWidth',lw,'HandleVisibility','off');
            hold on;
            set(gca,'ColorOrderIndex',1);
            plot(Q,AUC,'o','MarkerSize',ms,'LineWidth',lw);
            xlim([0 1]);
            ylim([0 1]);
            hold off;
            set(gca,'FontSize',fs,'LineWidth',lw);
            text(.05,.9,sprintf('N=%d',N(n)),'FontSize',fs);
            if n==1; ylabel('AUC','FontSize',fs); else; set(gca,'YTickLabel',[]); end
            if n==2; xlabel(Slabel{s},'FontSize',fs); end
            if n==2 && s==1; title(Mlabel{m},'FontSize',Fs,'FontWeight','normal'); end
            if n==1 && s==1; add_label(AB{m}); end
        end

    end
end

save_fig(sprintf('%s/fig6c',save_dir));