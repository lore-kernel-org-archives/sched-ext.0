Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86163242AB;
	Fri, 21 Aug 2026 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787339291; cv=none; b=KliepbyNYX6PfJSmRf0JFWax3fymuPAGipdYMtz3b1ABYubKLIEs6EEO6ah8cxZ69xd6tOyPRE/pXgfo1NaU6tIhF0aHtvkT0kWTqCgWwfo7iykaVX5ADwZQnHRpPBHOEnvWsHRwkjHZbSL7FrJPxO+0bcm63e4uD+1pp25fXeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787339291; c=relaxed/simple;
	bh=qT4xBVkXUFuNuQ1KUefCXWsEyt83Fwj1RUJaoajfm3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAOm1fupPABnh3NUY729nffR9AP8X6GPGzWs/6YqlEeE5bylikGZ4nvSRLnV3oUwjJNNWmWPEaxS34LykQO1yiEkc2UHANTkQ56TcjsIUK6JWlmDTgMYJjBgap0fLMVdqor7aJnHvDixpHaLFJ2JYbJYBkjoSgyU660Ik4sULVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzfZ3hxW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzfZ3hxW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C3D1F000E9;
	Fri, 21 Aug 2026 19:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787339290;
	bh=1v5j83rDSTXwAQXugG2RGa1wroSyAhy1LGYmRgaHT/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LzfZ3hxWyGT+7nxzuO9qgCSIEh1/KbesUKmaZFwBKEq8BkYE1AE7URicjKntSUC+6
	 hpnIuDvNJnMcmm8LAR1prctaBBu1HZYv7iT033KAafE7PlAPU5hswHewvQIo+RibHR
	 5U0dxNLlwZ7vasstInvtIVbRoLE0y2yGo8HFk5uM7LBOs4xKNvtXA9j1FjxmiyO60P
	 5uHXYM7XPzZbSg3A/DsIo/yzw7ctdU9yQBGwyt15Kk1W+9ux0tZBxiQZiFodjN+wcs
	 vleFI3cI0z+GOxd2ybrGNIfsok6CGKqm566GQbHfIEfkEpqLZFMtR8DkS4Go6SuxQx
	 ES+sGakuG9euQ==
Date: Fri, 21 Aug 2026 09:08:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal Blaszczyk <michalblk@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: Lift cgroup update locking to core to prevent
 CFS/SCX divergence
Message-ID: <aoiiGQttAjhxe8HK@slm.duckdns.org>
References: <20260820160956.910663-1-michalblk@google.com>
 <20260821140818.1559100-1-michalblk@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821140818.1559100-1-michalblk@google.com>

On Fri, Aug 21, 2026 at 02:08:18PM +0000, Michal Blaszczyk wrote:
> +DEFINE_MUTEX(shares_mutex);

Maybe cpu_weight_mutex?

> +static DEFINE_MUTEX(cfs_constraints_mutex);

and cpu_max_mutex?

Thanks.

-- 
tejun
