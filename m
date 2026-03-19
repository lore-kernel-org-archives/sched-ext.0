Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CFF1A238F
	for <sched-ext@lists.linux.dev>; Thu, 19 Mar 2026 01:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773882059; cv=none; b=bdNZI/u9FBzeML8ZTfGmjdBAcLQw0LKrBqtlkZaP3ytZ719Y8mmufg0uDE81uX8TXz/56erVE4S3XRJ6BIKd7TvW0KiBS3q9C4ukGhiPTgA3dN2JTZLjoMsfIFrrBJYS+2OLQGlc5PCy/LgdzGVfAxjNgXKI997ZXV8RKikddb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773882059; c=relaxed/simple;
	bh=wdRzlDW/vSvTm7CN6hahPVzHXznk+58BgROJpWXqQ0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WM5LIu18MM7IAvJcxkt31EaFCnQkwnNPSeZs1nEqT0Br8kbCP1XWwEctUhdaLN7lgdHE/Y2cekS0aNtf3JpE7JQ0jVy61jelCPJttxrHJyT5cVcbYf/en11LZDwQcYJ2RP0w8cFOkFQOy0fVGCHRaG1xHdUGdAoFRTvTcTdMwyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGRRkSFX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGRRkSFX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D4BC19421;
	Thu, 19 Mar 2026 01:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773882059;
	bh=wdRzlDW/vSvTm7CN6hahPVzHXznk+58BgROJpWXqQ0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UGRRkSFXqHwfUV1IdwwFRiGKf4m2bLOe5IELvaDvaLPY30iwmzjdVUSXy8tSE2ye2
	 1yfyuAX7GnGKQOz3yo2FUDN8HadNrFgdrHUUBZok2ihF/M1Z7FEa64AR/cft4Z2F5a
	 2C+szWgZLftcZ3IKpGGl3ZZaCwWuPB7FcacvhAwEqwJnoxJ6J3S5qiP0+TTOflajDZ
	 Brz6Jao6UkF0cEtwSfvTXA3fGJ7V8kFr2sfjwGMorKnrg2pHPKI4as/uVdXzWpB+Cf
	 ec19rJnkG60CVT9rDZuu/N4utvsrDuIeEVtaTRPOOhg/MVeXo1cqrWoWcmsOGWyepw
	 aR9Fvxw67xXEw==
Date: Wed, 18 Mar 2026 15:00:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.1] tools/sched_ext: Add error logging for
 DSQ creation failures
Message-ID: <abtKyRjGXYXgWZo1@slm.duckdns.org>
References: <20260318140839.497706-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318140839.497706-1-yphbchou0911@gmail.com>

On Wed, Mar 18, 2026 at 10:08:22PM +0800, Cheng-Yang Chou wrote:
> Add scx_bpf_error() calls to scx_qmap and dequeue selftests to
> improve debugging when scx_bpf_create_dsq() fails.
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

Was this actually useful to you in some way? Did you actually hit DSQ
creation failure? If so, how? If not, I don't think it's a useful thing to
go around and add error messages to whatever that may fail. In general, I
think it'd be far more useful for everyone if the development effort is
guided by some actual problems rather than just scanning the source code for
trivial things.

Thanks.

-- 
tejun
