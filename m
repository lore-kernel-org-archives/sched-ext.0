Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828F429BDAA;
	Mon,  9 Feb 2026 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770667831; cv=none; b=mGP1wk7AFvslnDqIlQ98Z64PV422oGNLjtiFxH+G+9WPj0y1YZeOPFPizuSIoBmwS4Sxlx3wcS5NTehHYnhb6PbT04qXJGLVefUBw4XKeRAYE/SnKHU4K1T6JOt3Rysb4dYc+qW2y/+u7lW17nZG2Q1rtJbjTHUQuIEA/6P9Ipk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770667831; c=relaxed/simple;
	bh=CU4CFqcfoKqnJ1/D1O57lNSaL5Uov3uiBiR6frIZZE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLrAqm+1ZtsIf3EnMUNFC/WYSmZ995FXK2RcXhQaLgV9Np07MCyxnDY2szCGDRRIxNpXozFBwZ+ktSO92OMHMVhNQ3nISuyeVpeTQ8gcjDd/3sxR9uIyfALkRkIGnXlOW8yfzfTMky+SefWfdsz0lb6yPbMOkBlDyVrurJk3Wt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kc2ipby4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kc2ipby4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B55C116C6;
	Mon,  9 Feb 2026 20:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770667831;
	bh=CU4CFqcfoKqnJ1/D1O57lNSaL5Uov3uiBiR6frIZZE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kc2ipby4AJGPI/Sxazqu894aGJBEhvmCA8CmgISEoUeSevzhf/U93Jr/9uykwAdZH
	 Ej7xxrJDd8w3CrhBbO0mB0HGdw4N/F5US/RlnxbFtJuZmhp2aJuaUpqlZC/zlMIawp
	 /dJXFEt8AhVC2c767XtDo1bDVb6/Z7N07Of9FaSZ6T/c7P6iRH2SzbB27MMg7TrXvn
	 aRlZe54DuJoKCSAKvVkfJysBYXX6fNquiJYc2BxUlGaTkmNCVObuprtaVY4avbgE1W
	 7qFojxjUTFJar11zKWatRsd75XEg/NIZu6VBVMp57+ZumSVuDD8hAOYD7oJwoG0XqG
	 3XT7fuqq+4fiw==
Date: Mon, 9 Feb 2026 10:10:30 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add test to validate
 ops.dequeue() semantics
Message-ID: <aYo_NsAkKvyMoXYv@slm.duckdns.org>
References: <aYhRKbkHf-or9lNO@gpd4>
 <aYhkv2K99aqiuwr5@gpd4>
 <aYiVv998mfMGVMCq@gpd4>
 <DG9RY7Y4VMWB.2IL8Y6Z4P5IA8@etsalapatis.com>
 <aYjtOQP0tmGIqoOM@gpd4>
 <aYm00oHl3BRWNFFA@gpd4>
 <DGAIRREHTBTV.E8XTJPHQUAN8@etsalapatis.com>
 <aYoAmES8tKNZJkdx@gpd4>
 <aYoYECCY_k1IrGqp@slm.duckdns.org>
 <aYoyxIkzp0E5dL1g@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYoyxIkzp0E5dL1g@gpd4>

Hello,

On Mon, Feb 09, 2026 at 08:17:24PM +0100, Andrea Righi wrote:
> Agreed. And just to be clear, for the purpose of triggering ops.dequeue(),
> **all** direct dispatches from ops.select_cpu() should be consistently
> ignored, including dispatches to user DSQs. I'll update this behavior in
> the next version, because this one treats direct dispatches to user DSQs
> from ops.select_cpu() as if the task is in the scheduler's custody, which
> shouldn't be the case for consistency.

I'm not sure about that. ops.select_cpu() doing direct dispatch is just a
shortcut and should be treated like the same operation being done at the
head of ops.enqueue(). That's what's happening semantically and I think we
should stick with what's happening underneath - ie. make ops.select_cpu()'s
shortcut the special case, not whether tasks in a user DSQ get ops.dequeue()
or not.

Thanks.

-- 
tejun
