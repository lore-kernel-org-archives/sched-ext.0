Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F14633987F;
	Thu, 21 May 2026 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380998; cv=none; b=uhXiOnOVugjSOZlw4LnkAKFU2wFaXX/1R1A96J3wkFZkkDvFHRif928rdzTiNEnAvP0yrvO+ZHXgU81H0Elzfrm7C38cKQSpT1/XtgaB/gYTSNa3h4jvmG2vJ41ZszchWiZL3ynQzTGlCliqSKiZY/ErjB8fUnjbV2DEpFv40Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380998; c=relaxed/simple;
	bh=S46WOv36ftn+jNBXGtGpkeNVC7WQFJQh7Z06RXezojE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=mGRlMRnjyKoS9OHkOiRAxVv+vg6AaZAGc0DLMI7f8cQpGzgOeeHJnYi/ooRK3yzwk7xSuBnfQ77rxZMiKc8zlQIp/cYQlGnnLfcofySTgqVL2DUUSZ4TzjiMbeVvHMC6QySoSwXWkL6Pu8MfgrbU91aNqHXtbzyv/nO8zN2x3B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvvRRrbm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvvRRrbm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9351F000E9;
	Thu, 21 May 2026 16:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779380996;
	bh=uCQ+OxNhVWY/94AhtqkKMa2GxeRjYKsB+UD3mYfJdz8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MvvRRrbm4WXTwkQELTIRZvG+nm+pn8KzWUci2QCkhacO+waMngnmOGV1RR8miMP01
	 A/WmEt55sIpZQt7Tsz1vq9hi/cH5ySd2eVGzDd29QN2WYM2kpQrhd3k651vaIGeqLY
	 DXlmIQkFbWzPWLSHk9V5NpMG0hqtBa2zWz65S9xq7km5v2NmMdz4roJlM/udRp3Qyi
	 nDre1k7TZXwJC0hHVvctWx4v4bGz3mKCdxX+BwUj4/t5tXcLgnU1DgsfGinvipftPO
	 TUKBY3wvO9742POkFc/LICv9TsYgN6EkE0H1tXgmMdZ9TEYcYBf2tVNk0iwszwLPBj
	 rZsJpj0fhe9aw==
Date: Thu, 21 May 2026 06:29:55 -1000
Message-ID: <741c392f7c7d4f1a1875feccd9785822@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Samuele Mariotti <smariotti@disroot.org>
Cc: arighi@nvidia.com,
	void@manifault.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Paolo Valente <paolo.valente@unimore.it>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH V2 0/1] sched_ext: Fix spurious WARN on stale ops_state in ops_dequeue()
In-Reply-To: <20260521105911.1814606-1-smariotti@disroot.org>
References: <20260521105911.1814606-1-smariotti@disroot.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

> Samuele Mariotti (1):
>   sched_ext: Fix spurious WARN on stale ops_state in ops_dequeue()

Applied 1 to sched_ext/for-7.1-fixes.

Thanks.

--
tejun
