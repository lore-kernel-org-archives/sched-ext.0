Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19EA31A572;
	Wed, 24 Jun 2026 22:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782341072; cv=none; b=h5D2m2LmkV5d7Tie5kbbokV4dF/ob62bONBforAEAtpwCzK0n2NiI+gss2MMB/29OUXRINp0CiErv5485orTMaOUUwVZcjnYDqB8LwNGOX2sJSuyx8RLmTzfEhgWNF17tiK9YVHAGJZxrnA5K0ClwCispH53ZwvMf1Fe7TULdPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782341072; c=relaxed/simple;
	bh=qdYU/bSf6LLadGni+Kxk1fW265eoaZs78Yoz5MHEv2k=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=n8vtNXwwTooEt9oxuyz4AsGCc9NRQIp+jyPR+YMfKJlAcojhsEYleJA9SnN3FcGOGynPx4DqZV2jQwF99sxmT6hE75l9pVCwhaf6+oI+Hxh7OiangZ8jJuI0xQHjtnzd2t9fxZRo0MiIxBGLM18f2iC8eAYpp5l51aUoPT1WrxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MC/aOAvt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MC/aOAvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121141F000E9;
	Wed, 24 Jun 2026 22:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782341071;
	bh=qdYU/bSf6LLadGni+Kxk1fW265eoaZs78Yoz5MHEv2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MC/aOAvt3BSLD763EN29zGiULKM69OvDX4oZ80EdnISu7ScrlJqtFeBStGqn41XhA
	 g0LHNe777zFh/nF5jW+VdrjEkZEWqpEfGXNMr79CJEMstOd/pNZ4KcW2FcCqz4Lcaj
	 ZxMxHMMjvv8zW/hHsTGgTPSyXSQ5+oLMNzGQDyGVDUOKEhzeWEOnGxS73usfDCJNN0
	 TFvu1goym4HE0EPkn0NR3vyvM8UX+inHpA7SgzovoG7UVRpghnTz6VWz3nhVEj6MxP
	 hbooDPaLKklFmGQyXrSqQVAw6lQpBnuJSaXjL2CUped/HpE9aUeSPTcOX4NC5uWrDK
	 w6N+CQVdd26tA==
Date: Wed, 24 Jun 2026 12:44:30 -1000
Message-ID: <8f2270cda5a59697b983bd053d5ea1b5@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.2-fixes] sched_ext: Annotate ksyncs with
 __rcu in alloc/free_kick_syncs()
In-Reply-To: <b5ba1ed0bcc9d72988f6606d39753c8f@kernel.org>
References: <b5ba1ed0bcc9d72988f6606d39753c8f@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.2-fixes.

Thanks.

--
tejun
