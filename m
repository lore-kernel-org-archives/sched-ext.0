Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A098A4A139B;
	Wed, 17 Jun 2026 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781715335; cv=none; b=TEq3YQ6thVwTlqbeADjsjvRGfvBnfah5H4+vIrCxVxtiP2uM7AgdH3rPJjgKceXsbhfOsJPDUYKfB5mDXnIif/8+RspSZWg48hJyz99Nk2c7XDyMXne6XO4/6eGVP/wYKzYogn3PUvwmYh3/GbTjC5RANV8DZVrYPd9Emql2iBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781715335; c=relaxed/simple;
	bh=URy8vc9Kk9wVRU5o0ZF7wNk7ozlBPJPKeZbQyeorlPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gb15NzAIU+5phR1khN0HLUcQJ7tF6nGgt0c0uztdx0EkQSAIQg524To+oe5/Y/zQ5xISpjr3WeQMX7OaKZLQ+EwbRFyNI72fza9JzDDygoMjCLxklen0wIjmYCaaEzhwPFfsOln33Qx2gqlWoGwb/0pZ10g9bAn4FhIFZcU1BeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCA1zs+y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCA1zs+y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA111F000E9;
	Wed, 17 Jun 2026 16:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781715333;
	bh=8q+yL0XniohwFXuPSAfY9RyYaCSOt6yHALjcxfWZn08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KCA1zs+y2yg5mxzYiB/wk6l9eB36obb0R6oJaOerHO7bb4e90WgUQCTNOM76rypp3
	 pwmnqZLBfs1K5ZkSAPF/ZQvhHIt+/9y5nHn9NAd6doNW+EM/keuyTxLIGV/X/vGS6/
	 oxt8lsPcqcEf2RyttDLflTYupyaGY/793/wdxvgqSBGU3Wz+7oPQs2oIttb6EeaMgX
	 gKEtOUW0Hm7xO5wsdFyDOCcWlD8t2vl0hz4c6s4IabxuznsrgsC3WNpuZPsa7ty4MJ
	 vbhWeEe1EGxwOFw66VhAgBKfUR70indCtzoRixXJaNq9jHqHdWnJIRC5mCU+Nkbez9
	 +FgXrwrtpNdgw==
Date: Wed, 17 Jun 2026 06:55:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] sched_ext changes for v7.2
Message-ID: <ajLRhLp9XiOwVgnf@slm.duckdns.org>
References: <6a0da8f90fd3890f734555f1632a3a0f@kernel.org>
 <CAHk-=wghMm2c+AYEcwYY7drSVXB27DYqc-ZXpFiq=XFs-w59wA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wghMm2c+AYEcwYY7drSVXB27DYqc-ZXpFiq=XFs-w59wA@mail.gmail.com>

On Wed, Jun 17, 2026 at 12:19:09PM +0100, Linus Torvalds wrote:
> On Mon, 15 Jun 2026 at 23:56, Tejun Heo <tj@kernel.org> wrote:
> >
> >  create mode 100644 kernel/sched/ext_arena.c
> >  create mode 100644 kernel/sched/ext_arena.h
> >  create mode 100644 kernel/sched/ext_cid.c
> >  create mode 100644 kernel/sched/ext_cid.h
> >  create mode 100644 kernel/sched/ext_types.h
> 
> Please don't do this disgusting thing.
> 
> There's a reason we have subdirectories: it's to group files together
> and separate them out

Sure thing. Will reorganize in the coming cycle.

Thanks.

-- 
tejun
