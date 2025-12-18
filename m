Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD87334C04
	for <sched-ext@lists.linux.dev>; Thu, 18 Dec 2025 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766052560; cv=none; b=D03mlkTtn1ZzdoI9+qfvgzm52b1rRdyyM2DFN9+icM8C/VKGwBTCfkDOqWaizClXXdjL1S/eJD7gY+kadyXMmEl8tO0xXC/HSI8tQ83yxdbZesuVplTVFoDH+CS2WJNx4lWRLboR4ACX0Wr0RKX+ha7dh4vzglsPRP8vVF9AICE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766052560; c=relaxed/simple;
	bh=+Zc57uQSzPymm0Mj+XzTsaRjHrLEz1e1GnM+LTdykw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Yy4ERBhA7UXozQBRML7NiNajH8lbegkxoqSFDH0V2qVI53p7VD3QJg7NQGXUO5rnhd9Qkfdd2Up5J6mOjQwHKObWXv2n8fMk/0WRkc3TbPcKskXpF2VNSidqnFRnHK90mLe/I7KrzaW8KTLAWLlqTajK/Zy2vQqfG56ULiYP0rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nbMLs1ci; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nbMLs1ci"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251218100916euoutp02f3627caa59f538b56037a88365f19a8d~CR3F46iB50197701977euoutp02q
	for <sched-ext@lists.linux.dev>; Thu, 18 Dec 2025 10:09:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251218100916euoutp02f3627caa59f538b56037a88365f19a8d~CR3F46iB50197701977euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1766052556;
	bh=+w78iIycq5xjJBsbNLCYPskBo2lk3lb6WPHKN2TyWMQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=nbMLs1ci6VDM/rmb4+xahQ6z9scpAyHlW6hgHw3K5RWSC+PiZj/oBs+EEvuwmKiXe
	 Co3NnWP5cVlZRo8KqySr0QgL+P87PD38l8hU5OsJhKOl7QuxK1ysNKEXYOkxPdXQt+
	 GVAiRlfcnrNQ2wumykhVyM4IexTfNWqrDIyI3ohQ=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251218100916eucas1p2258bd5447be988f61f3358963de1cebf~CR3FhxWTB1589015890eucas1p2t;
	Thu, 18 Dec 2025 10:09:16 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251218100914eusmtip20ed75045bfb25b9db7146e239780129f~CR3EBwJJN1362113621eusmtip2H;
	Thu, 18 Dec 2025 10:09:14 +0000 (GMT)
Message-ID: <a6150003-7f87-4f24-9156-bec10dfb70ce@samsung.com>
Date: Thu, 18 Dec 2025 11:09:13 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 4/5] sched: Add assertions to QUEUE_CLASS
To: Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
	vincent.guittot@linaro.org
Cc: linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, tj@kernel.org, void@manifault.com,
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, Heiko
	Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20251127154725.771691954@infradead.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251218100916eucas1p2258bd5447be988f61f3358963de1cebf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251218100916eucas1p2258bd5447be988f61f3358963de1cebf
X-EPHeader: CA
X-CMS-RootMailID: 20251218100916eucas1p2258bd5447be988f61f3358963de1cebf
References: <20251127153943.696191429@infradead.org>
	<20251127154725.771691954@infradead.org>
	<CGME20251218100916eucas1p2258bd5447be988f61f3358963de1cebf@eucas1p2.samsung.com>

On 27.11.2025 16:39, Peter Zijlstra wrote:
> Add some checks to the sched_change pattern to validate assumptions
> around changing classes.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>


This patch landed recently in linux-next as commit 47efe2ddccb1 
("sched/core: Add assertions to QUEUE_CLASS"). In my tests it turned out 
that it triggers the following warning during simple 'rtcwake' test on 
Hardkernel's Odroid-M1 board 
(arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts):

root@target:~# time rtcwake -s5 -mon
rtcwake: wakeup using /dev/rtc0 at Thu Dec 18 10:01:28 2025
------------[ cut here ]------------
WARNING: kernel/sched/core.c:10837 at sched_change_end+0x160/0x168, 
CPU#0: irq/38-rk817/79
Modules linked in: snd_soc_hdmi_codec dw_hdmi_i2s_audio dw_hdmi_cec 
snd_soc_simple_card snd_soc_rk817 snd_soc_simple_card_utils 
snd_soc_rockchip_i2s_tdm snd_soc_core hantro_vpu rockchip_rga v4l2_vp9 
v4l2_h264 snd_compress v4l2_jpeg videobuf2_dma_sg videobuf2_dma_contig 
v4l2_mem2mem videobuf2_memops snd_pcm_dmaengine videobuf2_v4l2 snd_pcm 
gpio_ir_recv dwmac_rk display_connector stmmac_platform rockchip_saradc 
rockchipdrm snd_timer videodev snd stmmac industrialio_triggered_buffer 
kfifo_buf rockchip_thermal phy_rockchip_naneng_combphy videobuf2_common 
spi_rockchip_sfc soundcore rk817_charger rockchip_dfi rtc_rk808 
rk805_pwrkey pcs_xpcs panfrost dw_hdmi_qp analogix_dp dw_dp 
drm_shmem_helper dw_mipi_dsi drm_dp_aux_bus gpu_sched dw_hdmi mc 
drm_display_helper ahci_dwc ipv6 libsha1
CPU: 0 UID: 0 PID: 79 Comm: irq/38-rk817 Not tainted 6.19.0-rc1+ #16288 
PREEMPT
Hardware name: Hardkernel ODROID-M1 (DT)
pstate: 404000c9 (nZcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : sched_change_end+0x160/0x168
lr : sched_change_end+0xb0/0x168
...
Call trace:
  sched_change_end+0x160/0x168 (P)
  rt_mutex_setprio+0xc8/0x3a8
  mark_wakeup_next_waiter+0xc0/0x258
  rt_mutex_unlock+0x88/0x148
  i2c_adapter_unlock_bus+0x14/0x20
  i2c_transfer+0xac/0xf0
  regmap_i2c_read+0x5c/0xa0
  _regmap_raw_read+0xec/0x16c
  _regmap_bus_read+0x44/0x7c
  _regmap_read+0x64/0xf4
  regmap_read+0x4c/0x78
  read_irq_data+0x9c/0x460
  regmap_irq_thread+0x64/0x2f0
  irq_thread_fn+0x2c/0xa8
  irq_thread+0x1a4/0x378
  kthread+0x13c/0x214
  ret_from_fork+0x10/0x20
---[ end trace 0000000000000000 ]---

real    0m5.547s
user    0m0.004s
sys     0m0.011s
root@target:~#

I don't see anything suspicious in this stacktrace. Let me know how I 
can help debugging this issue. This board is the only one in my test 
farm which triggers such warning.


> ---
>   kernel/sched/core.c  |   13 +++++++++++++
>   kernel/sched/sched.h |    1 +
>   2 files changed, 14 insertions(+)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10806,6 +10806,7 @@ struct sched_change_ctx *sched_change_be
>   
>   	*ctx = (struct sched_change_ctx){
>   		.p = p,
> +		.class = p->sched_class,
>   		.flags = flags,
>   		.queued = task_on_rq_queued(p),
>   		.running = task_current_donor(rq, p),
> @@ -10836,6 +10837,11 @@ void sched_change_end(struct sched_chang
>   
>   	lockdep_assert_rq_held(rq);
>   
> +	/*
> +	 * Changing class without *QUEUE_CLASS is bad.
> +	 */
> +	WARN_ON_ONCE(p->sched_class != ctx->class && !(ctx->flags & ENQUEUE_CLASS));
> +
>   	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switching_to)
>   		p->sched_class->switching_to(rq, p);
>   
> @@ -10847,6 +10853,13 @@ void sched_change_end(struct sched_chang
>   	if (ctx->flags & ENQUEUE_CLASS) {
>   		if (p->sched_class->switched_to)
>   			p->sched_class->switched_to(rq, p);
> +
> +		/*
> +		 * If this was a degradation in class someone should have set
> +		 * need_resched by now.
> +		 */
> +		WARN_ON_ONCE(sched_class_above(ctx->class, p->sched_class) &&
> +			     !test_tsk_need_resched(p));
>   	} else {
>   		p->sched_class->prio_changed(rq, p, ctx->prio);
>   	}
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -4027,6 +4027,7 @@ extern void balance_callbacks(struct rq
>   struct sched_change_ctx {
>   	u64			prio;
>   	struct task_struct	*p;
> +	const struct sched_class *class;
>   	int			flags;
>   	bool			queued;
>   	bool			running;
>
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

