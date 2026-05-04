Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE933E5568
	for <sched-ext@lists.linux.dev>; Mon,  4 May 2026 19:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921636; cv=none; b=SRo6BbN58xdHn3+l6WPIUk3wJN5gz1cToRIAqXLiC9pXHxyzGqvvZUTBTnkH3tdmQ+QT4OYQzwg1zaFX3BjXKTbzO1LmZXfPNc7wajC7Y1b5xE58NOrmTx4HE/2wcdzbqqg5EgDqLN5i5GruCWysyVgKnr1pZSbtwjxyYwGg6Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921636; c=relaxed/simple;
	bh=wrcvcDQM9qzv6zoJI10nTJQbS729ZfeVfAiP8RdSGe8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=smgsyS4U955Zu3wGelMj2Q1qinNmlAWL1NLw/F+z1evYJDcE7tVCmtfVwzBnwzxpo+qVOcmD4UU7+hecpvA5uqj7mt2gfeod/ogvBmy7uiU5m6rqkaqr3Z/HXy67vsIj9A4nEqBtxlgql14VQJF9oic8sZCDpDkySNKrS1MZhTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWGvEuSr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWGvEuSr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E694FC2BCF4;
	Mon,  4 May 2026 19:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777921636;
	bh=wrcvcDQM9qzv6zoJI10nTJQbS729ZfeVfAiP8RdSGe8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=CWGvEuSratycJ+DQ6uUIBz+enfhuQXpXG91/KLQ3ht4eIphd/4KLDExk6FC3QE7ZR
	 3xu5kQ3LEsPleAEwVvAbTv6s1usXN/0lCY4YQmbk3LXh4egSkzwXo56q+YZiexiDDj
	 2PmXUg0o32Tc5LjpnINZYEXuo99CgX4vWuYxfKQE+xmrGLRr0TlPZqaHZKAGClYe91
	 VBk8X+D+8C749TMbGV7K2UT2UkCC/GnIssW2OYHk6FX1hliPmRpiPhkkawsd/Zi8q6
	 yVXBFF/UY1ttPyMBJkcwMJI+BB7XXVK4Qp5WA62+ltf9gkJJ4AQJPiWKkfTjYxUE3o
	 RAr29fIP78ugw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] sched_ext: Fix exit_cpu accuracy for lockup
 paths
Reply-To: sashiko@lists.linux.dev
To: "Cheng-Yang Chou" <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260504161543.674488-3-yphbchou0911@gmail.com>
References: <20260504161543.674488-3-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 19:07:14 +0000
Message-Id: <20260504190715.E694FC2BCF4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] synchronize_rcu_expedited_wait() incorrectly passes the detector=
 CPU instead of the stalled CPU or -1 to panic_on_rcu_stall().
--

commit be51680372265a1376da290cd206c8c990bc5343
Author: Cheng-Yang Chou <yphbchou0911@gmail.com>

sched_ext: Fix exit_cpu accuracy for lockup paths

This commit updates lockup detection paths to pass the actually stalled CPU,
rather than the CPU executing the detection code, to handle_lockup(). It
modifies scx_hardlockup_irq_workfn(), scx_rcu_cpu_stall(), and
panic_on_rcu_stall() to accept the stalled CPU as an argument.

[ ... ]

> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 82cada459e5d0..fa83e273a6487 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -675,7 +675,7 @@ static void synchronize_rcu_expedited_wait(void)
> =20
>  		nbcon_cpu_emergency_exit();
> =20
> -		panic_on_rcu_stall();
> +		panic_on_rcu_stall(raw_smp_processor_id());

The commit message states that recording the detector CPU rather than the
stalled CPU is wrong.

However, in synchronize_rcu_expedited_wait(), it appears raw_smp_processor_=
id()
represents the CPU waiting for the expedited grace period (the detector CPU=
),
not necessarily the CPU that is stalled.

Does passing raw_smp_processor_id() here contradict the patch's stated goal
by incorrectly blaming the detecting CPU? If identifying a specific stalled
CPU is difficult in this path, would it be more appropriate to pass -1 to
indicate no specific CPU is targeted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504161543.6744=
88-1-yphbchou0911@gmail.com?part=3D2
