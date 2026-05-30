Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A70327874F
	for <sched-ext@lists.linux.dev>; Sat, 30 May 2026 05:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780117570; cv=none; b=lDMvpuKUnmJ0LSelrn7bmvtxxmD9HimKkrU2MQgDUqTGrDqB2b68RxgjU7Tm22WW3glrtLURmr2alZiHYSco4KK568VSiK9eOq1/SSycVMMBDfD776Xhp455CstqTRlgQgE/LAr/U3XiRibRKUW79Ga1cX1H5oUyw6lmBXCaXZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780117570; c=relaxed/simple;
	bh=jZW/h0L71tOXj5QQdmWlP76DvpBaf55k9VUqHUX7v9A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eIYzYIkdbvvZrzD1savqtAgNrOQA+PwD2UotW2BsEBhWzmdvah0gEI0X5KWTLD2Pi/3DTZJXPlQHZ4ZmgjdIEg8ZE9FtnaLDNSccY4RAIkcN894zqPYVaYtCqIjq6YAFApLSaLqdhlAQ9hH76402apQ8AeFFVND2C/z5xD8tuP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCSYUOr5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCSYUOr5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0FB1F00893;
	Sat, 30 May 2026 05:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780117569;
	bh=WHNOx6lkls29/0E279+9tGTBN39OFcMaYbUMkeoITEk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PCSYUOr5Hs/enPG97Ws1c/qwKE8HeW8ukY+jEzvjjM2rTSAvPaUKtpraS9qv3R6R9
	 QqNiaUV7iExWUQkemEs8ne5KK7x2r+YAQTXCa7RSyhOGPc3psgJkeo56+80DAQRG0f
	 57WB7+Diy83gi6SENs0i+DxkX7AkZ/UtpNFVkxwwDOImCWwoRRVlHF6MVmhNvQmTXJ
	 fCQjDhQpPhqXfBT2RkE637ddRGtJOmCnArfhEDMejujK5nGAVuJfDJqC1G5qLwqhmB
	 FPI0RruFOPjpuPGNPToFjeQJYhUg5zgRqeS70a+3+bW8L09sUYoplb1eN4pSiWWAY/
	 MZDsR2NxRuy2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] sched/fair: Rebuild load weight when switching to
 fair
Reply-To: sashiko-reviews@lists.linux.dev
To: quzicheng315@gmail.com
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260528131238.3879110-1-quzicheng315@gmail.com>
References: <20260528131238.3879110-1-quzicheng315@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 05:06:08 +0000
Message-Id: <20260530050609.0D0FB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Updating task load weight without scaling its PELT averages corrup=
ts load_sum when attaching to fair.
--

commit 5e323dec0121afc6858dcf6c332ec85a8dc01718
Author: Zicheng Qu <quzicheng@huawei.com>

sched/fair: Rebuild load weight when switching to fair

Tasks running outside the fair scheduling class may not keep their
load weight in sync. This commit rebuilds the load weight from the
switching_to hook before enqueueing back into fair.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 62a2dcb0d03e6..3671b512dcf7f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c

[ ... ]

> @@ -14957,6 +14957,15 @@ static void switched_from_fair(struct rq *rq, st=
ruct task_struct *p)
>  	detach_task_cfs_rq(p);
>  }
> =20
> +static void switching_to_fair(struct rq *rq, struct task_struct *p)
> +{
> +	/*
> +	 * Tasks may come from classes that don't keep se.load up to date.
> +	 * Rebuild it before the task is enqueued.
> +	 */
> +	set_load_weight(p, false);

[Severity: High]
Does updating the task load weight without scaling its PELT averages corrupt
load_sum when attaching to fair?

When a task transitions to fair, switched_to_fair() enqueues it by calling
attach_task_cfs_rq() -> attach_entity_load_avg(). The attach_entity_load_av=
g()
function relies on se.load.weight matching se.avg.load_avg to reconstruct t=
he
unweighted load_sum:

kernel/sched/fair.c:attach_entity_load_avg() {
    ...
    se->avg.load_sum =3D div_u64(se->avg.load_sum, se_weight(se));
    ...
}

Since load_avg is based on the old weight but se_weight() returns the newly
updated weight, load_sum ends up mathematically scaled by old_weight /
new_weight. If a task's nice value was changed to a lower priority (smaller
weight) while outside fair, load_sum could be artificially inflated by a
massive factor, polluting cfs_rq->avg and disrupting CPU load balancing.

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528131238.3879=
110-1-quzicheng315@gmail.com?part=3D1
