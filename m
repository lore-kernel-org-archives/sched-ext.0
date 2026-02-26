Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A35426692;
	Thu, 26 Feb 2026 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120885; cv=none; b=nS8eXTenT2pmZ2D4jzKmZ8VDIGSNHGljodkS4XcS/VfiTC8UhAIfW2112ylwX29T9XAzKEDZj/xiKUh43yVqHXGqpoXGqnr65LCSPi03oq+ZXS8oLJqro+ZYQGqSgvX2YR0pFkXFcnEEbscyjW8CrfywDroLOMGqitgq8szso9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120885; c=relaxed/simple;
	bh=Pj2akRlPZFvoAOBrdR47o8auo2facSqqnbvIMle1W98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENpDCAwTZaBhaFyF5hvgwEWV3J5y8u1aneaAJLc21DHfNlnSkGUAhFp17qwZrZGARKda/6DtJcsb33ADmAMLDRoJPkdzaTtjhLnEnHdsnqswOR+Wsn0NKICtod7RTGE7XBLopYULQxARhKhd0AM50gfd6UqOZ3FpJwCbEQgWpHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5MGt1J1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5MGt1J1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEE5C19424;
	Thu, 26 Feb 2026 15:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772120884;
	bh=Pj2akRlPZFvoAOBrdR47o8auo2facSqqnbvIMle1W98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L5MGt1J1C6/ghRT45FuKU8l1VUmINre9XLn74QeLYJxxgJOpLoK+6Ulj+q784+gMZ
	 jvoRc75iWmIFCs8FBfEJ4VTFhoso29OMUW71LJm43kHNEUk+YZcZLk88xZpLDo+LFy
	 TM64P/XuzwgZcmAL57Z0T9nsy9Cds9JdTBaJNJ4W6X++yaN28EqRAnyzmPB9/xI2nu
	 +h0CRTs5xTEWhfG3zlQbWsYIcpoKLL1VM/eVbHZq3dYIvehqvmKwbguguCAGpw2T0S
	 K2uej+3rFMkTYtYblIZwHHrAirZXdWj56RloSDB/W/RxVAjAT2I/4YKbCBE6LY+JyG
	 yt48mHHekpMpw==
Date: Thu, 26 Feb 2026 05:48:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrea Righi <arighi@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, sched-ext@lists.linux.dev,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 14/16] sched_ext: Export task_is_scx_enabled() for
 verification
Message-ID: <aaBrMr5O4455oU31@slm.duckdns.org>
References: <20260225095122.80683-1-gmonaco@redhat.com>
 <20260225095122.80683-15-gmonaco@redhat.com>
 <aZ8snSHWw-U0lVz2@slm.duckdns.org>
 <8fbc3ced19fb0c2a2171708073fa51ae308755b5.camel@redhat.com>
 <aaBlJT9Mac9KQpKL@slm.duckdns.org>
 <f49a6db6f0070350cb2d2b023b5733a3646996f2.camel@redhat.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f49a6db6f0070350cb2d2b023b5733a3646996f2.camel@redhat.com>

On Thu, Feb 26, 2026 at 04:42:34PM +0100, Gabriele Monaco wrote:
> scx_enabled() might as well be exported (together with its static key), but I'm
> not sure exporting the sched_class is the right thing, since all those scheduler
> things are quite private.

Don't you just need the sched_class pointer? Can't you get that from
kallsyms?

Thanks.

-- 
tejun
