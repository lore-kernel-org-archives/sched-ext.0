Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793733349;
	b=upl+auQpUSEnYwssjdvqfHnWflZRr4FlkYXdD30UcKsmfbu29+jHSXaY24kTSwVIbke6
	 psXrf/8FEquyriGAwVOF8kOCLBy8yJ61dZb6BRx4Hm4mnNdIADN+V/0l2scHcS1ZUmek4
	 18jDLn77l/aEhANj2r8/4KS0l5UxNbC35VQOSycR3sb3rgcSEx1+LOw4rmXMBrjyYn2gX
	 wEQSnAk8eSruQP7bxHxWrtW65i+8UqHf7bb11HWpDIhoNDEaihiSYotTlzOHXix/vqeqr
	 vxApK02BYDpAbu7UOAQm/zGgKSmAQmIi0/ot2X4or4bQ4IXZvceEtBMSDIYb8muAlhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793733349;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DTuOsuewEHZ4KygM0mZEBBB3hzxeoBRU3cfnHdi5uOc=;
	b=KstF3aWUQI/OeeC7s2NvvD8+dSfeuXU6j3PE/Ecgncwoi/U2F4Ui+7BQLh2wboM3gYH9
	 X6+ozgQCDUyTj6C2P5ZbQbpYUnQDF3GvPUJCHx+8c5aRWNkXDUZB+c5md9mHPUfkNgB9E
	 vZPZfNG7CnNrqRCgKKb+Xq4E6/bm1h+BFHyNeEL2xTiqqt1Mz/eWEYHiM9XJnHU9/g6dv
	 sfDEU5qwB/04qpmSgbxMwTeBSjcI8aYpROGRLPawdvhIQ+9ope8pVpDDR8tLHsVYbvhOE
	 6Ma32cI7TQXpSkfT9Dds8Ikpmotqjv1Z4CQ6en5otZB/CQUhBrSqq7R6XF6L0G3PNCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iRWIqyVz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37837606A324
	for <sched-ext@lists.linux.dev>; Tue,  3 Nov 2026 19:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iRWIqyVz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCC11F000C1;
	Tue,  3 Nov 2026 19:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793733348;
	bh=DTuOsuewEHZ4KygM0mZEBBB3hzxeoBRU3cfnHdi5uOc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iRWIqyVzXt2CSnHKvvRs8E//aslqPA54fuvLRgS+bv9gM0w1NXsKnPsslD76zi6CQ
	 LujR+Wj3xiMwLyVVqYt+xLltsNvAb04KpZ07cEJd/lERF2WTdBJUSFRFDv6r6o8rgQ
	 t9lTjr0d2is/dJwkmOHGyzvmPnV9J3fG60Xam8eQDcpa1fsWL6Eqj3FFfgaic6ZOow
	 /LusDSoCyfZqvxN5/UT3ZdfBvYsLmGd29DHrsjnmYK2BJxe8auh7yUTxJYPiYJLX8O
	 HKjR7T7AKcFbC0pJivK6zidA3Uv+WvkBJbxZxdePB5ooG/A6pwz9/J9aIl5FzCNNW1
	 yrEZjtNL+8gsA==
Message-ID: <sashiko-outbox-195908@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y 2/2] sched_ext: Fix scx_flush_disable_work() UAF
 race
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuba Piecuch" <jpiecuch@google.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20261103190805.3487350-3-jpiecuch@google.com>
References: <20261103190805.3487350-1-jpiecuch@google.com>
 <20261103190805.3487350-3-jpiecuch@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 19:15:48 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] sched_ext: premature return in scx_flush_disable_work() on SCX=
_EXIT_DONE
--

commit fe0315a0808b95d01cd45741655ca111deb8afc1
Author: Cheng-Yang Chou <yphbchou0911@gmail.com>

sched_ext: Fix scx_flush_disable_work() UAF race

This commit updates scx_flush_disable_work() to loop while syncing
sch->error_irq_work and flushing sch->disable_work until sch->exit_kind
reaches SCX_EXIT_NONE or SCX_EXIT_DONE. This aims to close a race window
where bpf_scx_unreg() frees the scheduler before a concurrent scx_vexit()
queues the disable work.

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index d2460a88fba35..78f15ddc0aa5a 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4217,8 +4217,13 @@ static void scx_disable(struct scx_sched *sch, enu=
m scx_exit_kind kind)
>   */
>  static void scx_flush_disable_work(struct scx_sched *sch)
>  {
> -	irq_work_sync(&sch->error_irq_work);
> -	kthread_flush_work(&sch->disable_work);
> +	int kind;
> +
> +	do {
> +		irq_work_sync(&sch->error_irq_work);
> +		kthread_flush_work(&sch->disable_work);
> +		kind =3D atomic_read(&sch->exit_kind);
> +	} while (kind !=3D SCX_EXIT_NONE && kind !=3D SCX_EXIT_DONE);

[Severity: Critical]
Can scx_flush_disable_work() return while sch->disable_work is still
running if sch->exit_kind transitions to SCX_EXIT_DONE between
kthread_flush_work() and atomic_read(&sch->exit_kind)?

In scx_disable_workfn(), sch->exit_kind is set to SCX_EXIT_DONE at the
start of the work function before running scx_root_disable(sch):

kernel/sched/ext.c:scx_disable_workfn() {
	...
	while (true) {
		if (kind =3D=3D SCX_EXIT_DONE)	/* already disabled? */
			return;
		WARN_ON_ONCE(kind =3D=3D SCX_EXIT_NONE);
		if (atomic_try_cmpxchg(&sch->exit_kind, &kind, SCX_EXIT_DONE))
			break;
	}
	ei->kind =3D kind;
	ei->reason =3D scx_exit_reason(ei->kind);

	scx_root_disable(sch);
}

If CPU A is in scx_vexit() (or scx_disable()) between scx_claim_exit() and
queuing the work while CPU B enters bpf_scx_unreg() ->
scx_flush_disable_work():

1. On CPU B's first pass, irq_work_sync(&sch->error_irq_work) and
   kthread_flush_work(&sch->disable_work) return as no-ops because neither
   work item has been queued yet.
2. CPU A then queues sch->error_irq_work (or sch->disable_work), and
   scx_disable_workfn() starts running on sch->helper, sets sch->exit_kind
   to SCX_EXIT_DONE, and enters scx_root_disable(sch).
3. CPU B executes kind =3D atomic_read(&sch->exit_kind), observes
   SCX_EXIT_DONE, and breaks out of the loop without ever having flushed
   the running sch->disable_work.

Could that allow bpf_scx_unreg() to call kobject_put(&sch->kobj) and return
to free the BPF struct_ops map while scx_root_disable(sch) and ops.exit()
are still executing? Would reading sch->exit_kind before syncing and
flushing (or performing a final kthread_flush_work(&sch->disable_work)
after the loop) avoid returning before scx_disable_workfn() finishes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103190805.3487=
350-1-jpiecuch@google.com?part=3D2
