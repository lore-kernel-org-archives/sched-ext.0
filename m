Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED5030FF1D;
	Wed, 25 Feb 2026 23:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772061852; cv=none; b=IJyhqGI7s5MR7/xb530PsNjgGzIrriBPWgxnMK1J8kt8SrO/vqqAS8fWk1lZ/dN2F5EAT2/uxOhPlXxj0SR97ANQIcvX90n2PKIcc8FsNVN8pj/PC8Qhue9GVZbnJ9+LdXdpCxKqsbMQFhiJu4HXV+AK4xARRYy2DonavZB6Gh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772061852; c=relaxed/simple;
	bh=S1On8hlmSQwc805fJapFUdCiWcyyQWDXVQS3j2V4nso=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Sit2KlNzQ/r2b0OnmM2PU50X/3pj7YsB4ot67Ls3s7pq5DAC1iUs2Ly4tNOJl9EYQoVHj4AcDqoWVvo28vUxj1ppYMrtndvN0EJXyrJQ4Wqu28R/YzNKTQDZgDD/00wu+DZedwDssiKuryxflYeCLR684vDHqEwwl3vEiUOKqSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZ0RvZqG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZ0RvZqG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F0EC116D0;
	Wed, 25 Feb 2026 23:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772061851;
	bh=S1On8hlmSQwc805fJapFUdCiWcyyQWDXVQS3j2V4nso=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RZ0RvZqG990JBHMgWAOR9sCl9Kxl15CkEBd+yQWH4bFIQ0fH9f7yau1kisErC9oUl
	 QA439tE1UMFfJnQSPNfLAF0YYXOXNgLGxoL9WmX17mvtbs+AqEqSn+6QBZsXl4NO0i
	 9seJ35nuatr4dIIy71Nupocrb1NRDuXTXO+EGm2IFBDmKYNCU1Q769vRKpMw9YybLV
	 rMgtCTRLjm18S+BJl+dt65n53uOeugPDIRjco+oEf8c6uAcDLsLL2i6zDvHjgxHgyF
	 9JnBBAQ9/9fHTozRT2A+2dPAcTKGX2LiF0uZwwYOIXcTAwu7JV1DmID/IjKIojl2Kk
	 KmhD9EXSNmv3Q==
Date: Wed, 25 Feb 2026 13:24:10 -1000
Message-ID: <b95f1d5b16a5ca9e136495c63bc01510@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Carlier <devnexen@gmail.com>,
 David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] sched_ext: Fix out-of-bounds access in
 scx_idle_init_masks()
In-Reply-To: <20260225211523.399284-1-devnexen@gmail.com>
References: <20260225211523.399284-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.0-fixes with a minor comment cleanup.

Also merged into for-7.1 with a conflict resolution against the kcalloc to
kzalloc_objs conversion.

Thanks.
-- 
tejun
