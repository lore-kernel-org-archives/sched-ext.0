Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E069376BC0;
	Thu, 20 Nov 2025 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656529; cv=none; b=SaAupeYx8Sf3yao0G8f5CqjdkImmrPsk3IaJZNx47Xk5mdSA7AYfqf5RuSQUroyBBEmBEWmdyHlmgGfJP4G3c8iXwziXvVCjbExR2ZF9QgHK3jrbyIjvO1j+S65VKwSsy2FwCHyAjyi3AN8lwtTXvPDvNVavSzG6iwlpk45rfrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656529; c=relaxed/simple;
	bh=enIWCilS/UO8wrj6GjUyxKIdUFoCpwEuIY97Wzkedus=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=H8W0qOOYuczkHQcOGEJSGtcweG385Hey883NQSmQXV1bMVmnlKYTYN3F7XNIXCB66B8sS7lTsQwNAggZAy+PetZYIeoylEIOIHIAhlcFmtQJEwiYx1bWJKI4GqcTbzI0riYIrd0lC52Fd8D4QxLutsusBHhxeJkgzt7obprwWmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3Djd1/G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3Djd1/G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12079C4CEF1;
	Thu, 20 Nov 2025 16:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763656529;
	bh=enIWCilS/UO8wrj6GjUyxKIdUFoCpwEuIY97Wzkedus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k3Djd1/GtLaTBMWcWMCBpJgy5ELTOUdz+KSoRS0fA3RYbeMf/yFPnJaENtmnx/f8A
	 dGxoBmtf9bM5XgVxaDEgLgzzMxSgQ6IpbfJmDkJHWlqxTKTheUYN9rFpokN17I5zqn
	 RGLTJI30Xm2z7xzOhu23NEg3qfagRG847wLYzzwYhY0+qY/z97vj+DzzwXx3ewJzOR
	 NWGtVAlbyq/T5OxxmGf/VfXNh2Dd7b0+j94le+pHo4/yQaQyQmUYXu3OSKEGRSqbFl
	 5eoI5iAI6Y+rDw7fRctO4Feo5GZnDRywqFSiOQjTjtnxp66ld9wwtt+vUQskrJoFb0
	 yMOwetNJLA/OA==
Date: Thu, 20 Nov 2025 06:35:28 -1000
Message-ID: <68602d24aaa9b02c9d09b1eb91639b8c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 hbathini@linux.ibm.com, samir@linux.ibm.com, sachinpb@linux.ibm.com,
 void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 vishalc@linux.ibm.com
Subject: Re: [PATCH] sched_ext: Fix scx_enable() crash on helper kthread
 creation failure
In-Reply-To: <20251119103722.309211-1-skb99@linux.ibm.com>
References: <20251119103722.309211-1-skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.18-fixes.

Thanks.

--
tejun
