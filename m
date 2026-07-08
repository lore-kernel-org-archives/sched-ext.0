Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ECF3D171F;
	Wed,  8 Jul 2026 19:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783537796; cv=none; b=fRyhf8yOl7Kgo0U5eklzW/qEcZOU23WdaWYD9Y+VhimGnG+JkDJwO6ETG5IlFMKYF/hcgPvqKtGNLY/VBgMB3cvYkrNbsBt4UmmBiYCUaiXJPUr2oKWPpFZrvRheZFX5KbSJwfyK5LOC2k4VPAG816EzjNGTYOkJgLrlxZjov5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783537796; c=relaxed/simple;
	bh=fVPEkWDqLbP7558GtgY40/7/NSDI0iQs6qzxyjISczg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=eAsTgGzGFcx1HHFZPs/FlXDla32bY7yfrMEZBZNtDEcLIL2pKbH5XIDbKUe09jvRcPEtXQ+R48wyUNmfFG1d/2VYoDFJOpa6PodkzLV13gfXvGyQp3X80gOHfbx+hsfVy2J6mIv8e2HFoLuhz9UZseMRxZCVEnXXhzWPbvjUNSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdBGA703; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdBGA703"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264031F00A3A;
	Wed,  8 Jul 2026 19:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783537784;
	bh=Kk1kzK4WYrj/Y/V+W/d8BMh25Owm1wi6vU/fHLz1xe0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MdBGA703JuO1vuIorSt/JuJLATsFZ27aEsRogHvQGgv1qZMpo43s/CcAqF/5fg4ZB
	 8tnJLcwbb00F1I/38eIr4Gc4vnUbBCAa6+bhwuJXaWogFR4zOrCF+Sp2kw58Xziq3I
	 87YXzRl0EisW9mHeo/iDMsgdajrQqByJKX7VtngLW0vj6khJ+BYJcIBS1wkis8hufA
	 36mZWfbsBW0F5ldq9E2voCmS40WMbRo2m++T5QQrvRxkh85eyswGpCDN/RQbFCL64y
	 YPinaq4XpIbgPTweCzJEoakEFiKuufZGDOEkvEFJJmsiqE5zVQ1crQdyuU/ca34yPR
	 D5kV3w1Gp3XXA==
Date: Wed, 08 Jul 2026 09:09:43 -1000
Message-ID: <90174d41528bb30ba43cb15bc448c2fb@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 34/36] sched_ext: Add scx_bpf_sub_kill() to evict a child sub-scheduler
In-Reply-To: <20260707004248.3D6FA1F000E9@smtp.kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org> <20260707001229.1410929-35-tj@kernel.org> <20260707004248.3D6FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Tue, 07 Jul 2026 00:42:47 +0000, sashiko-bot@kernel.org wrote:
> - [High] The `fmt` argument in the newly added `scx_bpf_sub_kill_bstr` kfunc lacks the `__str` suffix, bypassing the BPF verifier's constant string checks and allowing a malicious BPF program to trigger an out-of-bounds read.

This follows the established _bstr kfunc convention: the fmt / data /
data__sz triple is exactly how the other scx *_bstr kfuncs are declared
and verified. Same as the v2 round. No change.

Thanks.

-- 
tejun
