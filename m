Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CE14207A;
	Tue, 24 Mar 2026 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363056; cv=none; b=u9pa/Yo3i8Qg5Getm9JGGqi26UP/TSY8mxW9/wd49ntopykXYW/J3E4wjIMxk36R+Ua6GiKZX+X96VJ3Ox/C6DDXy62lUUwwtm/LFGmYsNAc5gTZBEJBPwMpOokig7fsgHcZ4Rg4EwuPLqmjyDy4p4HJBaPMwebE5pGbf6PoqSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363056; c=relaxed/simple;
	bh=0HWk+iR7DUbQhZhnGA5YLIoFl7cHJjaaTekQtYa4QfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYs6VyXzgrz4xmZtFHhmLrFSakU5EVGNe25sK8JF/mFaZ+ovinfaJmhLyeGRsp0dPO74bNXEMwmOmymiKMvZctsQqYl5U57gmD3/IpeaST7TRbZHOh7fjsBzX6yptMyX+pkFpROjq/BS+37qt+XJ3JXky7o2VMJIVjNe3Nw6y8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqFu++zd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqFu++zd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB52C2BC87;
	Tue, 24 Mar 2026 14:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774363055;
	bh=0HWk+iR7DUbQhZhnGA5YLIoFl7cHJjaaTekQtYa4QfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pqFu++zdwPL+vXBQ21jTYiWYxhRd2Z+TupfumzZfmFmAlz2039kzZB7dz+3XrpTPB
	 E/Dwg6VFmfTCBtDpERHCbsBEPuYLAbIOCZthYn+CjF33mjxyJiQs0xuDDIevtpdsoQ
	 FqznDo7kwwOa8r9zQ8bEroca87AZ7utqs3RpwWpMTvKbCMg7AXi3Lh08V9f3E8fPyW
	 4p/YuRvMFtBkgGcBje13frmftNp7s6ovY+w8g3Vb7ckAp3iprXPFMK/SSmaIvPbLIu
	 J+AXUne2VpWBwK6tfNaIA4vjNStExMRaksxT7ybX7Hw/dxjO4XpJpQ+RONHVYs2fsn
	 GVSLio+z77pow==
Date: Tue, 24 Mar 2026 04:37:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Choose the right sch->ops.name to output in
 the print_scx_info()
Message-ID: <acKhrjVIHe08UA0j@slm.duckdns.org>
References: <20260324120313.12632-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324120313.12632-1-qiang.zhang@linux.dev>

On Tue, Mar 24, 2026 at 08:03:13PM +0800, Zqiang wrote:
> This commit use the scx_task_sched_rcu() to get task->scx.sched

"This commit uses", but that just do imperative - "Use the...".

> structure to correctly output, instead of always using scx_root
> in the print_scx_info().
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> ---
>  kernel/sched/ext.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 2472231ec556..5d670b50da3d 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -7680,14 +7680,18 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
>   */
>  void print_scx_info(const char *log_lvl, struct task_struct *p)
>  {
> -	struct scx_sched *sch = scx_root;
> +	struct scx_sched *sch;
>  	enum scx_enable_state state = scx_enable_state();
>  	const char *all = READ_ONCE(scx_switching_all) ? "+all" : "";
>  	char runnable_at_buf[22] = "?";
>  	struct sched_class *class;
>  	unsigned long runnable_at;
>  
> -	if (state == SCX_DISABLED)
> +	guard(rcu)();
> +
> +	sch = scx_task_sched_rcu(p);
> +
> +	if (!sch || state == SCX_DISABLED)

I think you can drop the state test w/ scx_task_sched_rcu() usage.

Thanks.

-- 
tejun
