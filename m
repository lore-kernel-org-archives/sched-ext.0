Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB35F2F8E95;
	Thu,  7 May 2026 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778188350; cv=none; b=g0TC1aPVETYP5tJfRP58KtroqYMwPbQcWB972R6Q77tZyvH5HEF7/6DVd4UUaTSajMp+Bez4iK9q/c1dUf6VGcrpjMyB91V6HUxawMIVWlweV1CYRML7CfnssRe72ke5j3ElLPCR1ecmp8xboEHUuOlzGyngJVAAYUxiD5YyjTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778188350; c=relaxed/simple;
	bh=txM0jDKzfi5J3pUFAoizvlgsBku4SNZjTkpxb3nB9Sw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=XBBMHdOh8wm0zLhc1PhaEUmZ4rT+0QeGORWHgD06gtZ4mQ7ielialDb0a6PxbH5fJqZRIuxVmU65egXRirPkZRRKHvewXJSBQtsHLvoSxddBHOeYzlb2N1O1QDy9yjUp1LYFG5IHPvv/56lI1RCmhQw+iuenqi0rR7lH0X+h3yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckBHkhAm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckBHkhAm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747D4C2BCB2;
	Thu,  7 May 2026 21:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778188349;
	bh=txM0jDKzfi5J3pUFAoizvlgsBku4SNZjTkpxb3nB9Sw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ckBHkhAm3TiGKNdRTLkY9CRLQK7WZjbFcrZ6pfp7y5gsVP0/XETLaZqzKgqyLhPqr
	 4J09Hz/OSLEg+6EuOoEh07rUmEJatZuL96yb7dLyhnYu1yTDNb7oqeqnGcq79u7dJo
	 +ApSZmhl9Ri5bgPzzyiytdm4NmjOc8wiX1fuCJVTT5Nb0Dx6JmiMl8TAYfHTufc3No
	 Li1IUMqkYqy2KWQpG1Z7xApstj3dfx/Uu7g/cKyHhqDDqBKlpFi4mrpbEuUBF1/MHD
	 5JdEyCdTmPdYKRDnb5AhaO+wCteSnnRr52j2sAployOJHFv8/W3eVp2L/NUWC6o9dl
	 Cj/IN9pDw0AOw==
Date: Thu, 07 May 2026 11:12:28 -1000
Message-ID: <23f0fa6a6b73cc94949e570fb4d7b88b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Move scx_error() out
 of scx_link_sched()'s lock region
In-Reply-To: <c14dc57cf2227c29e315122d11902a1a@kernel.org>
References: <c14dc57cf2227c29e315122d11902a1a@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.1-fixes.

Thanks.

--
tejun
