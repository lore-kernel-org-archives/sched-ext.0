Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DF137FF58;
	Wed, 22 Apr 2026 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876659; cv=none; b=RZBxWVzG/lxWm1M+IzUabF4rkG0WUdLhOLHC+HVJhTmPwyLy0oNsPeTcL2wCSdDTFSkXxEAoZ8IFlkcyNBHMVLcgOUjIVL8ZRVV5ps675ko/4Nj13mzSb20dKK23cHEYtaqa9sGQUiPFaTa/p4nUcqVnoTX+M0H2si4IA3oQT6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876659; c=relaxed/simple;
	bh=JqHVndBopXtaMTm5N3jvxxsGm2MplEEB8Z4nCMDC1rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rG0Ta3Znr3Ar3eKuCfeZdNmCwXItTcj8T6QMxaqn/r9YxhbvrbZUSz/ZxM/6n9D7OrnZiJ0RNK/XhJpgfq4auEZpofnli8yxepr9+v5qAxsgUqhhzGc9ZBKGw556bFN8K/fLsyfzGqsCiMsjRZVCuHiljpcJ8NNgV/6gM2TcCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFJro3+L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFJro3+L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B76C19425;
	Wed, 22 Apr 2026 16:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876659;
	bh=JqHVndBopXtaMTm5N3jvxxsGm2MplEEB8Z4nCMDC1rA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FFJro3+L19O+JvYDC1QdfMnP4+pqKT9ZDUqoIY6wSswQqCXUVFJeuPlh4fXo11Rpy
	 2E7K+2ltE+lQT6gmlG5aOoSfMczXICSGY6sq6ipk0g0e/gbMFXscRbF9n+klu6V5A6
	 fJ/576wrogttCBUSsIUqqnfbJafBsxavyUFeVgnZxE61Gyc7oYqPRneZRGS0cwbP8A
	 ZKJC/5bR1q5dN7bPJL/6fkz/xDeMAFBqz3tkOEpdic6fJr+t9RzJvhCxNLdcasoa2j
	 PWiDgKVF5gjLXCQLrNtWzdjJWRITG2C0XCYKtumje4cofplSdBl/mz5sawFC9NOqau
	 o5AawwgvoMrFA==
Date: Wed, 22 Apr 2026 06:50:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: SCX_ENQ_IMMED potentially leaving dispatched tasks lingering on
 local DSQs
Message-ID: <aej8cmhZVhsqogr4@slm.duckdns.org>
References: <DHZPHUFXB4N3.2RY28MUEWBNYK@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHZPHUFXB4N3.2RY28MUEWBNYK@google.com>

Hello, Kuba.

On Wed, Apr 22, 2026 at 01:21:27PM +0000, Kuba Piecuch wrote:
> diff --git i/kernel/sched/ext.c w/kernel/sched/ext.c
> index d66fea57ee69..480627fdc203 100644
> --- i/kernel/sched/ext.c
> +++ w/kernel/sched/ext.c
> @@ -3079,8 +3079,11 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
>          * If @force_scx is true, always try to pick a SCHED_EXT task,
>          * regardless of any higher-priority sched classes activity.
>          */
> -       if (!force_scx && rq_modified_above(rq, &ext_sched_class))
> +       if (!force_scx && rq_modified_above(rq, &ext_sched_class)) {
> +               if (rq->scx.nr_immed)
> +                       schedule_reenq_local(rq, 0);
>                 return RETRY_TASK;
> +       }
> 
>         keep_prev = rq->scx.flags & SCX_RQ_BAL_KEEP;
>         if (unlikely(keep_prev &&

Ah, good catch.

> ...but I think this only fixes the case where the RT task wakes up on the CPU
> that is doing the dispatch. The other case is one where the RT task wakes up
> on the remote CPU (the one the second task was dispatched to) after insertion
> of the second task, assuming the remote CPU is initially idle.
> 
> To fix both cases, one potential solution that comes to mind is bumping
> rq->next_class to &ext_sched_class when inserting a task into rq->scx.local_dsq.
> Perhaps we should call wakeup_preempt() in dispatch_to_local_dsq()?

I think what's missing is wakeup_preempt() call in
move_remote_task_to_local_dsq(). This is SCX's version of move_queued_task()
and we're missing wakeup_preempt() call after activate_task().

Thanks.

-- 
tejun
