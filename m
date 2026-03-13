Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9271DDCD;
	Fri, 13 Mar 2026 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773431161; cv=none; b=YzAFkr4uGwm0ARLWW7czLFWOXQmzibFr4aImPiC4C51SXwly13I7zqWgebPFV1aUvsTiIJ+bWwACpam6nkk5Am6il8G6n/0svbfHbpmOzTzhP2ujToKkdeN69ofwEnw0mUo7U7NVN/cdSJK53/suBVyaFfw4eGbQlbrMxK83v3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773431161; c=relaxed/simple;
	bh=TQMVNwieVA83s9AoUugUyR5oOMjqbLbKu8Xr4ny+Y9U=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=kJ+RHx/33oCCRvF8972+Qz5JJSNuBWIqN9bp4vTNSo3ARuNvWLY+fUNyFVirWxk97cGSTA9IxkFNQ61EdfoxujBPvqg3SS9hBIkmoPuw+s/mtgkfuhisUHhoBifjWJxzcC7XCuI0h7pHOgdGn8lZOIIRAyvZoYZVLd80NzDDtUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZO++f5i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZO++f5i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EEEC19421;
	Fri, 13 Mar 2026 19:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773431160;
	bh=TQMVNwieVA83s9AoUugUyR5oOMjqbLbKu8Xr4ny+Y9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UZO++f5iPiHBEdpnRx2hEjn82vs8icq49cvuV/AcCwRwPk0B25lZTmrCH+F5mV28x
	 B5jGUMQw7/FHXE8FmWxeQ5FJZqNcfLcwmZmlsEcZAb7mZq1SaYMMQaIM44Z/+jR/gy
	 iIncfiVCSIz7rdMlx8i5YtA3ga7YghaYTAMATq1mNTJLs6YNnQuUWQJzduDbo9792c
	 qCiycnyK8M+8fOVBLhv2tL3Ssunv5UThNSeuVOonfkNkfejIiFokVwa/JG2UNjkOEg
	 cWdZxq0ysvCDc+sSFf4iRznQJSVIvlng3rb/L288cyaOyQCOcFx6RcASpWq3MBJ3SX
	 Hm1D5rm/2KPPQ==
Date: Fri, 13 Mar 2026 09:45:59 -1000
Message-ID: <16b554d1e35432add8d32bfdd03b1a6a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v2 sched_ext/for-7.1] sched_ext: Implement
 SCX_ENQ_IMMED
In-Reply-To: <20260313113114.1591010-1-tj@kernel.org>
References: <20260313113114.1591010-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

> 1. sched_ext: Split task_should_reenq() into local and user variants
> 2. sched_ext: Add scx_vet_enq_flags() and plumb dsq_id into preamble
> 3. sched_ext: Implement SCX_ENQ_IMMED
> 4. sched_ext: Plumb enq_flags through the consume path
> 5. sched_ext: Add enq_flags to scx_bpf_dsq_move_to_local()
> 6. sched_ext: Add SCX_OPS_ALWAYS_ENQ_IMMED ops flag
> 7. sched_ext: Use schedule_deferred_locked() in schedule_dsq_reenq()

Applied 1-7 to sched_ext/for-7.1 with typo fix in #3 (guaranateed ->
guaranteed).

Thanks.

--
tejun
