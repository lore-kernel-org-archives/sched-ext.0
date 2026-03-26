Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB0027E1A1
	for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535103; cv=none; b=tRRkEn990kKSCQaf+6VyEuJOUSfB7fMH9qNB8s8iE5GdjsJC3y/zL5ulPWSmt26G3iW9Z6qH89eo81EGHTIyaPyTzcMhuX/XRpigKFpP4cu+tvZCY+ilYga1h4YynrAnF/1XEQH1nYgYyRqwLpoJrtEZWWsoERBvutD5jRMvNQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535103; c=relaxed/simple;
	bh=YA5cyptY4/7VQQzcLlF9gpvF5QPWM63Gue0HKcSgmzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agsbqT8S27vxnZbAZ64gwzjO+2ETPVDmg39aFgGFJfJfr6Yf/BVuJ5x5UvvyiFFFnUjZ0i3JZbom/F/MIVVn7JNlq3i2r+/tsJA8/Y47fwbjUHaBaE13U9RCrhBcoNSp6PvHYO6DKA8q33HXvBVq7brdVW4I3pAUpnA1tBDNC9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jt9XYavT; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jt9XYavT"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35a211df8e3so750567a91.2
        for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 07:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774535102; x=1775139902; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hcDVrtkqv6fdTECuQVog/FfRKCDCL5HcKYLugxyrDZ4=;
        b=Jt9XYavTbUOq5jp/+auLz4aMksnblqlSHLNNql6+3N4DmEiv3+EXV4HDX72bzvjWd4
         tCpEo2igU7NJlPig6r6oRlnrWs/+q70omLCQ1j09uK6q7AbVm9bqVwalEmDgSLZY8RGz
         47v0EZwBqB1fpabd0LvAE27uV4NFC8kbP6g/FqddIp11E14gMEAqLpzqCZkBpkLKw+wO
         ppodx6hLhWGE7NjnlWTgse3/Or3PtkMJwsfvBPoI2V/KfNFQrboSg7H0yjD/mOE4Cq0u
         tXSTu/gGQZ6ZN5lig6P3khC6BfGn8ktgEeT7TP9jfjOc427pNiyWaiZzqmQW6+fweyBV
         t6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774535102; x=1775139902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcDVrtkqv6fdTECuQVog/FfRKCDCL5HcKYLugxyrDZ4=;
        b=ZpR6r383Q0bbYnkjv5pu0hSZRX3Eneuc3uy3Pze+ay30cfbkwhtnAGtWXtT1u4MM61
         XNbRN8LrG9TiyiAIqPbp3EVFuNIa+d/FN1DxLMtGF1B9N93goQoPiChSexfwSiraNqne
         PG/eAU+i5qHHqmu7O76Kq+V2uhSZmkvzjAPe5umVWp6MI8aGgNc0Ax5s/N91crGlRLeB
         YE5KNsJ8xWQruwRwQe9bbP8wTB7zM6klmXqr97i255pBrpKgXrehIDl6NVADyDNMHfWW
         FdQ8RkYyBOy5r85z0fVMm1rjZiFCMCbTmH0QV8ZbtL9EuzOCwjzd7QCiqeQS64H5Nscf
         lLjQ==
X-Gm-Message-State: AOJu0YxoqDMWU4V1vIK6Bw13WvLinzI21GbRqpdBiwKoo5jt7uPStvuc
	tWPEQwBjHbscZRaEUVvrHbsI0hNGyf6VxfEpENXWBwkFUNkChVJbKJ3x
X-Gm-Gg: ATEYQzzMDejdd5ZniP0TNIWN5vJ/AH9xXEFi3g6JGtg06k5kNednEiMDMTdRlZRediK
	BFmegJVg0HTQPjwhgEHUXepCU+KIUlo7Yb2dC9oHdDZyQidGrRv2NxywGIkxWwR2M/RPyKD7FWI
	9TWniI+lvFfUtoFIMEm5eM4ael6oP83EJG7T3L3ZNnRAA7TBh6Q9Vv1N7wavZoo/upxfHbE9q+G
	Ya3+iccKGYEBT01ELvnN+MKEm0eWtv1SEqB2cIkDY6AdLh/qAerKtC3GQhb5MW7aBISDISeoO8P
	qWm2bfigWKlTD5zosM4OP6Rdg0CNsP2VlCMlctt0F2jn9QlrmKJWPanVGmeP5pFLz0qJRUhsXmr
	L6Fnz7W2f+Y+WjweeNMTAVc8nrZLWpkYSryExYR2OWhzMlcKu7aVkHCYbUXH4Pw9UM6Zv8bjABF
	fdV/AdiFU1gn6jUqXw6tHGJkMV1IJ+
X-Received: by 2002:a17:90a:d60c:b0:35b:a7be:ae68 with SMTP id 98e67ed59e1d1-35c0ddda140mr7211650a91.30.1774535101706;
        Thu, 26 Mar 2026 07:25:01 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:af69:9e67:ef33:2eb2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22db19e8sm1792307a91.15.2026.03.26.07.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 07:25:01 -0700 (PDT)
Date: Thu, 26 Mar 2026 22:24:54 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] sched_ext: Fix scx_bpf_dsq_move_to_local___v2() to
 handle SCX_DSQ_GLOBAL
Message-ID: <2bpxb64ymbxgtzodc5bxdmh5w7klr3xokyt7wccb2lzn3arxwp@yhu3jj4ury7w>
References: <20260326091756.816828-1-yphbchou0911@gmail.com>
 <acUXEy9NUVMb40Lh@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acUXEy9NUVMb40Lh@slm.duckdns.org>

Hi Tejun,

On Thu, Mar 26, 2026 at 01:22:59AM -1000, Tejun Heo wrote:
> On Thu, Mar 26, 2026 at 05:17:30PM +0800, Cheng-Yang Chou wrote:
> > scx_bpf_dsq_move_to_local___v2() called find_user_dsq() for all dsq_id
> > values, but find_user_dsq() only searches the rhashtable of user-created
> > DSQs. SCX_DSQ_GLOBAL is a builtin DSQ stored in the per-node pnode and
> > not in the rhashtable, so passing SCX_DSQ_GLOBAL caused find_user_dsq()
> > to return NULL, triggering scx_error() and aborting the scheduler.
> > 
> > Add an explicit check for SCX_DSQ_GLOBAL and use find_global_dsq() in
> > that case, matching the pattern used in find_dsq_for_dispatch().
> 
> This is intentional. Both global and local DSQs are terminal and don't
> provide interface for direct control once tasks are queued.

Thanks for the explanation!

Since the error message only says "invalid DSQ ID" without distinguishing
between "DSQ not found" and "intentionally unsupported terminal DSQ",
would it be worth adding a comment to clarify the design intent?

Something like: 

 /**
  * Only user-created DSQs are valid sources. Global and local DSQs are
  * terminal DSQs. Once a task is queued there it is committed to that
  * CPU's scheduling path and not subject to kfunc-based manipulation.
  */
  dsq = find_user_dsq(sch, dsq_id);

Or alternatively, a note in the kdoc:

  * @dsq_id: DSQ to move task from. Must be a user-created DSQ.
  *          SCX_DSQ_GLOBAL and local DSQs are terminal DSQs and are
  *          not supported as sources.

I think this would help future contributors avoid the same confusion.
What do you think?

-- 
Thanks,
Cheng-Yang
