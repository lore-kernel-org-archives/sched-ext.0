Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C32C43DA24;
	Fri,  5 Jun 2026 19:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687110; cv=none; b=VaP4C8Axj3trVgOkjdwdPt2Zx4Mp/7G28zGO3hFULoF+cJxpzNpS1zWDBLpg/LvZTenLmIOlgzAv6prC+4qfU7njwSOleYNGOVWyToZWYc4+6TuffhFAkRcWFdAfh1ZyMVS3Od3Le1ZdFo+7xPMFzH8XTMLHT/eQIL68QDRMjRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687110; c=relaxed/simple;
	bh=qwdHNsm339DgGlPwlYlDBmESvB43wCN5K9Fa8rDpWmI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=tpS2tHqmrJgXeY+drE59VMuSJGarlL2NH9kCMK6la9CZw0N6SUH2eY1tucZgOi28iqvXqKvaw4xe+d4wPNbQc5LUE9bFfP/8sq1obLjjX1e6B6HXA+3i/IPEj5LsPT5FSL+2rRqy4IQITJgfiMjPwyJEDH4mvU2MhyWKnGq1coQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQexEArk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQexEArk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680891F00893;
	Fri,  5 Jun 2026 19:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780687104;
	bh=qwdHNsm339DgGlPwlYlDBmESvB43wCN5K9Fa8rDpWmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gQexEArkeIG7IEayE51ex/ovqurwwBvxUOleLYXHnVziccPQ1fRY4pKS64jE90AcI
	 nNk/lvlCbkwaXPwginhvlbg/dBagipWpdKxDYbnI+iQNAXPqFvI1fuAURwe59uDid/
	 spWV2IKb2NCbz2MCw1EpHmpawPdWbPoNhnhAJUV6cl8eEOCeulX2kgD55QMKpXox/2
	 ipTByODSbPxSb20Z1hyhawSTmpyZ/YjzqzOPY6AT8BX+G+CkFO88ZNw/8VSe+wDzB1
	 bAbT9DcLjdsSgHMehwe4mh4bGLKf4dlZvYyEHi8dqnJROXvZgJBiAzpAaF3n9BsNcN
	 yUH+kaloRZCNA==
Date: Fri, 05 Jun 2026 09:18:23 -1000
Message-ID: <3ff09db09b52b01fcd5564cff01e18f3@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: Add scx_arena_to_kaddr() / scx_kaddr_to_arena()
In-Reply-To: <20260604100223.3831303-1-tj@kernel.org>
References: <20260604100223.3831303-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.2.

Thanks.

--
tejun
