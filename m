Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C370949AA4B;
	Sat, 17 Oct 2026 23:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792280115; cv=none; b=uzi6IwKHsKoHaGk7+5K4S/y9j13s8WHV693+WPWj7KY7A8pqt6dueze0n6+k2DG6cPgGeiURKBcGWJU682ynDFuS+9gUmwxKWbFynkhdn0xeByUv5l47SRlvaoEto3UkcKXMSo613UDa6lORPqurPWGXqreBQpOe2LG2u91InXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792280115; c=relaxed/simple;
	bh=WZUoy2E/DYgya/nCmdpq7wVQExIEgCaXp+2VwWUibRs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=vD1TYXMpGcApUopj+d5YMawwRnhzL78F/IbRQa7+biUPKlJpslIL+tWIhge4TTu+GqgK3HDj9pgTnc9Hp8W+UCFi5W5P9LiztoO5OYoIba8J7wjXGgDRlFJId86WLFjMRO1KyEe1ineGhX0GX830aqLBQqX+PW1Z+n/MtSR1ydE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKAG0IZ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKAG0IZ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455951F000C4;
	Sat, 17 Oct 2026 23:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792280114;
	bh=ky7MuN5jZxYimdaJM1UsqgBm09W594MJSCD0vQzb3DA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fKAG0IZ1F9I7JzT3gHVqcg4SsAZTbjyZFRnsJ48eKlVTNM93XYi9Oz4XH7mCxiekd
	 VoNRqMMzGlNBYCXb5AvczrtqLtQlfUssDXk/HqV/p/OYZcKngSm9VfruxfqVOTqeRf
	 DCR7DwzotejoxAHTI2o0nUNpMIWpHvP6PSmk6jzNwr9YgKbBWE0fbJIGa6eeY5OTWX
	 qnL5i/4AWf7ti1CRoFlmbPMeZcYAvFjTI/XoEEGQRUVl/JOd347ghADWaKKlWjZ6pj
	 WeXkF1NT/qpc5VMV5yL7mzhCHqbHaVAu26JRI8/VBs/Rvl0/748OVJcN5B841aG2E9
	 7+MlIqNOypwmQ==
Date: Sat, 17 Oct 2026 13:35:13 -1000
Message-ID: <8cacdbb7d499b8a5eaf09d052919dc05@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched_ext: scx_qmap: Also re-enqueue stranded tasks
 with scx_bpf_dsq_reenq_task()
In-Reply-To: <atP_f5S5v_1V06L2@gpd4>
References: <20261017223738.993262-1-tj@kernel.org>
 <20261017223738.993262-4-tj@kernel.org>
 <atP_f5S5v_1V06L2@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Sun, Oct 18, 2026 at 01:06:39AM +0200, Andrea Righi wrote:
> > +	if (p->pid & 1) {
>
> nit: if ((p->pid & 1) && __COMPAT_has_dsq_reenq_task())

scx_qmap is already 7.4-only. It implements ops.sub_cid_sched_updated() and
ops.sub_child_ecaps_updated(), which older kernels don't have, so it doesn't
load there anyway.

Given what qmap is used for, it'd probably make sense to rip out all the
compat stuff from it and just pair it with the latest kernel by default.

Thanks.

--
tejun
