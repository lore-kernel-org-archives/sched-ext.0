Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D494B35C6BB
	for <sched-ext@lists.linux.dev>; Thu, 10 Sep 2026 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030874; cv=none; b=bmZU4h+wmTzCJMrGuxv8ijtOCFtvFvJuKGDOqTPSG5zl6HSqK2hRLSp2hLgc1p5rnj2gERxiBS8YOepSKER3ceF9RCCony2lloTP99hD0iB3ZTWFdDlWbQixA+Bc+Tyy+xnBWGH2PQ+KhQChA5wEU3M5e66LAFBxKtyefQ87O5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030874; c=relaxed/simple;
	bh=ardW3K2/+znLoTSnakAwDIVp5jYBlIxRQjdm7NEvh1U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nBaiCDezBI3dOamqryFn9KQvjl3ylDx1jbai4QtoHZQ+GBt1wnK0dvaF+XyO+W5Oi5KTwBKG9L7pC1j+Vk3zcOdaszhHjYZl8aax5oXChD3TzYtJQtEK2YpmRdReKsieLmzDvotBuXQIszZVBD9lzedvZGWhixRVws/tGRXnHJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXN6i5WX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXN6i5WX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE431F00899;
	Thu, 10 Sep 2026 09:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789030862;
	bh=jPw9vcxiOk3uscyna+Yngy+pC4nlgfko3qc65hnDQ08=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aXN6i5WXHFZroFqDlj1w4NrI93gAi2fRNSfZ6gfpnLVMBYqM+4YkhDXA9CUXzLSMy
	 I2EpojsdhlwXCmpx/GvkLuHRc7Jn9AQJYSXvofE661CNC0HxowlbZXzkLmXPTlotuC
	 HMOOxtjTdSY+urA+mP/6u8FEQb4RSox+IcyhxRUyPpYcgChWWv1kZZL5evOgfexR81
	 ng3Fq7pq0P8mNFwF0x19J3ZBqnVTmMWQ4dX8qqF+fAb2OFPp7GK9TmD36o6yyXFNxN
	 g5+DqFz4wapBUHJI36/1cPIEPp4W57MGuE9QZqKJ7YVyRvflS31020jc+lfGijyRB3
	 FEa2vj465EWmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext: Close the pre-enable ops error claim window
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiurong Fang" <fangqiurong@kylinos.cn>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260910084533.2420199-1-fangqiurong@kylinos.cn>
References: <20260910084533.2420199-1-fangqiurong@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:01:02 +0000
Message-Id: <20260910090102.AEE431F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Concurrent calls to scx_root_disable() on the same scheduler cause=
 a double teardown due to fall-throughs on SCX_DISABLING and SCX_DISABLED.
--

commit dd97abeb536b6afa1a46d2a0b2de7e7eaddfef0a
Author: fangqiurong <fangqiurong@kylinos.cn>

sched_ext: Close the pre-enable ops error claim window

This commit addresses a race window where scx_alloc_and_add_sched()
publishes ops->priv before transitioning to SCX_ENABLING. It moves the state
transition before the allocation and adjusts the early exit logic in
scx_root_disable() to prevent a teardown shortcut from racing with the
enable workfn.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -6395,8 +6395,9 @@ static void scx_root_disable(struct scx_sched *sch)
>  	case SCX_DISABLED:
>  		pr_warn("sched_ext: ops error detected without ops (%s)\n",
>  			sch->exit_info->msg);
> -		WARN_ON_ONCE(scx_set_enable_state(SCX_DISABLED) !=3D SCX_DISABLING);
> -		goto done;
> +		if (scx_tryset_enable_state(SCX_DISABLED, SCX_DISABLING))
> +			goto done;
> +		break;

[Severity: High]
If two threads concurrently call scx_root_disable() (e.g., a SysRq disable
and a BPF error triggering scx_disable_workfn), both will serialize on
scx_enable_mutex.

For the thread that arrives second, if scx_set_enable_state() returns
SCX_DISABLED and scx_tryset_enable_state() fails, the newly added break
statement will cause it to fall through the switch block instead of going to
done.

Similarly, if scx_set_enable_state() returns SCX_DISABLING, the adjacent
case block logs a warning and also breaks out of the switch.

In both cases, does this allow the second thread to bypass the early exit,
acquire scx_enable_mutex, and execute the full teardown sequence again on an
already disabled scheduler?

Could this result in memory corruption from double frees (such as calling
rhashtable_free_and_destroy() on scx_tid_hash again) and duplicate calls to
the BPF program's exit callback?

>  	default:
>  		break;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910084533.2420=
199-1-fangqiurong@kylinos.cn?part=3D1
