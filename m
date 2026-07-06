Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB023C5833
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381250; cv=none; b=WcxfmAvTWsx2KVj2/ooqeY0BRfQbiSZ8Fdl8VQNjvsSMeV/Zpk9JW5u61QPS5piKv4qKBbmePX6Jbqdu2g67XPrnf0Bwmwz9rsl6XoS2m3aCTpjnMWLiT91V7462fdwrslI00zSSRpeo8z32zB4ZymPLUNkROdgMaFeFIJ89fSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381250; c=relaxed/simple;
	bh=RLqmv245vQu+3CeFg3i6LZ8ApNaw6cbOEPdDW/f9OCw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=qMExNKTnCdAfNw8gjqJYp/03FzxueorNaKYaMFZsIFPj8yXGb/lqdF3z/IAFpTk4eDowJPozCdNTxFHPOngjLHzbY1R+/yAQL8Db7WjrxeUr9GFeIFgxkEtKV67n5TQ9cAHG57xhTfmp9LSzXO7550c2E2YoFHrY02/RkodKz2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QylqnDQ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QylqnDQ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E446C1F00A3A;
	Mon,  6 Jul 2026 23:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381249;
	bh=RLqmv245vQu+3CeFg3i6LZ8ApNaw6cbOEPdDW/f9OCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QylqnDQ00S85G89+BOKKrD/TaaoTikbkhtE59L69Tfz08nGi+rnRclT3uTLSICGfF
	 IPco79A9OiuYfbdgaeoqAVAGIo07jStdaqegq0d8WSj18Byh2i77PG0LDNub7alwjf
	 39Chz2zMTnQE+GVDFhTNJZUuv1o7YHu+qINGOThvPeQB2HrX2z95n4Zrr0Vlp4OCGZ
	 +4E8HNOjOpMir9wf6aaTG6HsFPV5qBunfR7zHthXTalpWDr2Q7N/5Pa+eXXQW6VKUi
	 qwSCMbg6BZv1FbXv2pKusbBhdJwcDBGTxWOm+JVaEB6/O4ExUBUr3LdLhUmHMxBMYV
	 L0M4wFjeHbRQA==
Date: Mon, 06 Jul 2026 13:40:48 -1000
Message-ID: <5a4b60d65952874b09fb3c8687033ad4@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 sched_ext/for-7.3 25/36] sched_ext: Add the SCX_CAP_ENQ_IMMED cap
In-Reply-To: <20260706021051.531C31F000E9@smtp.kernel.org>
References: <20260706014058.439853-1-tj@kernel.org> <20260706014058.439853-26-tj@kernel.org> <20260706021051.531C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Mon, 06 Jul 2026 02:10:50 +0000, sashiko-bot wrote:
> - [High] Migration-disabled tasks can stall indefinitely in a sub-scheduler because scx_bpf_sub_dispatch() skips the sub-scheduler's ops.dispatch() when SCX_CAP_BASE is missing on the CPU.

Real, but deferred rather than fixed in v3. A flag-gated skip is the wrong
fix - the kernel can't call into every sub on the chance of a
migration-disabled task. This folds into a broader punt-up model for
cpu-affined tasks under sub-scheds that I'm tracking as a follow-up, not this
series.
