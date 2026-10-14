Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4557255D895;
	Wed, 14 Oct 2026 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995935; cv=none; b=I8qCmgyLNxoluuQc6dFR5W2jRYjK3aX0vK7G0fT6/eC9seOb9gqc5Z1nYT6xQKpG5ukLXFQ4YDl+ZHiVKK493taBXCKlHQfH8Hzm4CWE2NNBPtb5+q521UYXhTs7dud84g6KP6oxe9tHaL/tj4pKy5/SvkRrS/Z2ND64x+hh1ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995935; c=relaxed/simple;
	bh=r0FDyL/H0SFtiy5Bg1FeRW3Gra/uqZokH1659OFaKMc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=p9J4m6StSze8yyaxhxDO6Ti82NpmPAiNNYJFryuYebmzNE2MHT4r7/SUuvZJT9LvNv0MzetRu0VfHitADb3AJJLMlb2YqcPRtsPV2IAr6sQkzzd+JV43CLBpnBJC7FNp/RRnSUPCrpL05nd11/1mOgYPlrpOYcUPlrejE/l+Zng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BO91bCC9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BO91bCC9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A825F1F000C4;
	Wed, 14 Oct 2026 16:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791995933;
	bh=3P22SYXjcygEyI/0U3bw/yQzaOLKYhA8pEGBTzjlke8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BO91bCC9gp5NyNUzD+UHcMwhBxcusbR78ksfDoF3eLNexk4wq4K/6UMZ6vDCnwoNG
	 oZn3Qt1Oz4eCcDIdJ61WeVNVWkyN0XEGgQv8cG983RjIPJNWGciG6V3Q42n8sDbOUl
	 C/auZLBo/oxbHPWhdaeSqTFM8UxPCrHBDw53G6iZnT1u3cxX2cEZhIj/z8ASBBgzdG
	 BRyni9ghQBYtQOEYsUAMiCZHUlsgjoRvYYRa9AN2+YRvWroVbJLfvMmfJj7TEMsw7u
	 2Db/iSi7pOZHGrSSnpq8mBA0Q75fjYbKaWYLiScRLwPQpxKVTxMTCluIoa+a4MpBh4
	 QQLF59c7fjRAA==
Date: Wed, 14 Oct 2026 06:38:52 -1000
Message-ID: <297ee1a03ba086fe0afd29e7a1e89367@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 fangqiurong <fangqiurong@kylinos.cn>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.3-fixes] sched_ext: Wait for
 SCX_OPSS_DISPATCHING on DSQ consume and move paths
In-Reply-To: <20261012210749.2955291-1-jpiecuch@google.com>
References: <20261012210749.2955291-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

> Kuba Piecuch (2):
>   sched_ext: Rename scx_reenq_wait_dispatching() to
>     scx_wait_dispatching()
>   sched_ext: Wait for SCX_OPSS_DISPATCHING before moving tasks off DSQs

Applied 1-2 to sched_ext/for-7.3-fixes with Andrea's Reviewed-by added and
the holding_cpu condition in unlink_dsq_and_switch_rq_lock() joined on one
line.

Thanks.

--
tejun
