Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A3E3033FE
	for <sched-ext@lists.linux.dev>; Tue,  7 Jul 2026 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435640; cv=none; b=ecZzyCioTXGW8CcnjM7G3ZWg8+zqeoTr/xjZenuUxLpQBttbb//CEwlvqL8A6taSjM3w3OsqqCr423/TLgBvLnD47wBc2d1+gxZV1mNhOeRo2M0satijdD7H5VlDVxl/1r1WU5bw22sNDbfXB349+7twGQx+gJpgcadYDhH2sKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435640; c=relaxed/simple;
	bh=rhxcdDygM3bkB/RRNyjuAyKtIMdZWaGZX89Fm4pN2xU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lIZ1i4/laxFPQwMfca+x4jvdYMnO/MwFTOEcQtuF1gjaNURuApCrFJYYSrMOSZAjTU0AyA27L+kj04mAOugphE5ha7UrCQt9f0e4YxswLquFME0JHof4kYLFkazJRgG2O3FCcz0pAGT7Jq4HhdpInaZ/xWJW+fG9G0XET+Enp+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjr1P4yk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjr1P4yk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7876D1F000E9;
	Tue,  7 Jul 2026 14:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783435637;
	bh=s84B8N2bYKJAd2CQfudc5KojM0iYOMHTKXVXROcvPc4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fjr1P4ykfiMgarp+DHhZhXUGd4KlnjhkJViUHgHQHpJiFn+0uiLAsN5+cU9j1weOy
	 dnfsm/zqkCpfYsFTnY0/AuvdGp/MnKPF5uN5Xsw1MRQRVDTiHCaFK6ajSNfl8fNAqm
	 yCmjclNiAQqIjQaq/vPlcCzi6aDfUtSf2mh9HbVhcDlf9+k7VLl3v49ZSLUp0QRU04
	 xCarC9QIrm/ChoWZ91XrnRkK4wgeFVe/GFyy7dHcTHfD3Suo2GOvWmk01Ko8tbi7T8
	 J3jHSe6e9eFNwyY6za2iRTuZaZNZOWkA/YQ5N2bPVYcRx3jFUJf8BGSVu1/TqL92bg
	 pbA+O67ppOvdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.2-fixes] sched_ext: Preserve rq tracking
 across local DSQ dispatch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260707135854.1379730-1-arighi@nvidia.com>
References: <20260707135854.1379730-1-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:47:17 +0000
Message-Id: <20260707144717.7876D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Unhandled lockdep assertion failure in scx_dsq_move() due to sta=
le scx_locked_rq_state tracking when moving tasks across remote rqs.
--

--- Patch [1]: [PATCH sched_ext/for-7.2-fixes] sched_ext: Preserve rq track=
ing across local DSQ dispatch ---
commit bf8a7ba58cd085582b43e1290a1b826afac5f411
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Preserve rq tracking across local DSQ dispatch
   =20
This commit fixes a lockdep assertion in dispatch_to_local_dsq() that
occurs when nested operations restore a recorded rq that is no longer
locked. It clears the tracked rq before switching locks and restores
it only after reacquiring the original rq.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 691d53fe0f648..aa79dedba8aeb 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -2588,6 +2589,16 @@ static void dispatch_to_local_dsq(struct scx_sched=
 *sch, struct rq *rq,
>  		return;
>  	}
> =20
> +	/*
> +	 * This may be called from an SCX op with @rq recorded as the currently
> +	 * locked rq. Clear the tracking while switching rq locks so nested
> +	 * callbacks don't restore an rq which isn't locked anymore.
> +	 */
> +	if (tracked_rq) {
> +		WARN_ON_ONCE(tracked_rq !=3D rq);
> +		update_locked_rq(NULL);
> +	}
> +
>  	/*
>  	 * @p is on a possibly remote @src_rq which we need to lock to move the

[Severity: Medium]
This isn't a bug introduced by this patch, but does this same lockdep
assertion failure happen in scx_dsq_move()?

Looking at scx_dsq_move() in kernel/sched/ext/ext.c, when moving a task
from a remote rq with in_balance set to true, it drops the this_rq lock:

        if (in_balance) {
                if (this_rq !=3D src_rq) {
                        raw_spin_rq_unlock(this_rq);
                        raw_spin_rq_lock(src_rq);
                }
        } else {

Unlike the fix in dispatch_to_local_dsq() provided here, scx_dsq_move()
does not clear the tracked scx_locked_rq_state before dropping the lock.

If move_task_between_dsqs() then triggers nested callbacks like
SCX_CALL_OP_TASK(sch, dequeue, ...), won't it save the stale this_rq state,
and then trigger the same lockdep assertion in update_locked_rq() when
it tries to restore it?

> @@ -2640,6 +2651,8 @@ static void dispatch_to_local_dsq(struct scx_sched =
*sch, struct rq *rq,
>  		raw_spin_rq_unlock(locked_rq);
>  		raw_spin_rq_lock(rq);
>  	}
> +	if (tracked_rq)
> +		update_locked_rq(tracked_rq);
>  }
> =20
>  /**

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707135854.1379=
730-1-arighi@nvidia.com?part=3D1
