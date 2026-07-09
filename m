Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5E13E2752;
	Thu,  9 Jul 2026 22:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636116; cv=none; b=iK+q5Uu1sLMgqsf2hdu26qcCe7UDT0iw9+WNNZbB2/YWV4tV7Dvg4c4DUb/0S2/Y4cWZ4XTk7WGAyXh8N+iT1xqmXa5DEkiMAVkhu/YUJrWpGVOz1olOMlXq2IuNBDxETVurPxse34MRnVt8MdOG2daQUNti8k2kX2DXu/xC3Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636116; c=relaxed/simple;
	bh=GfF3FtIyGGJpGtGIPmR0v/5GuM1GhCW4U4lAYMXESYA=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=CQYjwPSGiO6ha9klHrbYYvAu76rJ4yegQChccZgeiwj4FFOk8zS17ohuLU4QkufGfjYKlK3ZlbYKTtlMzCMi2gX/0+1fhF4L91P4kd+v69T0EiBosZl+eqhqqy2bjiKKqsIs8pw5gmG5kW2PxKJos76s8vODErAHxUZnCCutX6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMNLhl/M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMNLhl/M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE211F000E9;
	Thu,  9 Jul 2026 22:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636114;
	bh=ExbMW+qYlxIlLz/HELtapLaS1tJH9jsHfhyrWYWEoIs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=EMNLhl/MqwC4FL1ZsrdK+U/iG1o41zoQyQ2EpVdYfeKLtbjDjT5u1//2CWqLMpSyl
	 YxO/3Uyc3GuX7QgSYhFANkV/Rkx29e+qigHZTwZvn9mizXVNbT7WbiDpKSdAzFMYq4
	 X8pp2NZX4Hn8S+WePVFXJMF8ispHWF5vZKhoXFSBhwU1tvtBezAQuWMIylgZuIix8j
	 cs9JkXqKI75kOlxMH/g9qNYtBUMrFbhv40TzhGUq3SiPhAUkgxKS1wyCDq0yrqSMQR
	 t2sPN6hJmLpCXIq7kS495xtOTuYZa/LreIadUxVN0BLErdptAvSjCPsrkT6Rn60Qf5
	 o8/6Qulh56ekw==
Date: Thu, 09 Jul 2026 12:28:33 -1000
Message-ID: <04e7c4981076cfe0ff06e1f49bb75ca7@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260708215432.0DAD01F000E9@smtp.kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org> <20260708212429.3405787-12-tj@kernel.org> <20260708215432.0DAD01F000E9@smtp.kernel.org>
Subject: Re: [PATCH v4 sched_ext/for-7.3 11/40] sched_ext: Add ops.init_cids() to finalize the cid layout before init
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Wed, 08 Jul 2026 21:54:31 +0000, sashiko-bot@kernel.org wrote:
> - [High] scx_bpf_cid_override() partially mutates global CID topology
> mapping tables on failure, leaving them in a corrupted state.

Not in the current form: the kfunc validates the entire snapshot first so
that invalid input leaves the globals untouched, and no abort path exists
once the write loop begins, so a half-written mapping can't occur. It's
also only callable from init_cids, before any scheduling reader exists.
No change.

Thanks.

-- 
tejun
