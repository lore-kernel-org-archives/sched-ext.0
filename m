Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCD62376E4;
	Mon,  1 Dec 2025 20:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764622719; cv=none; b=bKVMsDf3dDCdM4HtW5fxFoK45v25L0vHmmE24YMCk3HRfpJ4e+ytKVypQ8/YGKP+TnL6XdbTCW/XD+IlYh5SNDAy3FdqZ7EXSnl0AYTTJRh/4ZPNNtInKcijIxheYhfVf/q2EMHBfxGlfZYwB7o6Qt6LVoMIETp/qZ3MpeITfxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764622719; c=relaxed/simple;
	bh=uRKr1MaiM+AIoJUE+bFWWYaIjRxDMaDGwuBG4AEsTSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=png4Y3c29OJILEX6dN1q6U/BKweQACqMmbcMt8KDg2Z8SWq+W4hMZmFNz5de3ZO6p8zqzSf+J9i/xxoM5q3CzQNZkW33XP4RsB22mpSaEecpnDhZK6COvhJmDOAnPyU5C7ap32SLyhsf45yo7BkaOJsCq3PgGUnk9r0AXMFtNaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAOEWgIx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAOEWgIx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03542C4CEF1;
	Mon,  1 Dec 2025 20:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764622719;
	bh=uRKr1MaiM+AIoJUE+bFWWYaIjRxDMaDGwuBG4AEsTSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tAOEWgIxyKETS/Sq2pDHACprVYqR0R/ivYOKBAEVEXjclhYJ46OYzl+0rHhYQT3Nn
	 pWq4uWRmDtwbadxmA+Hzp+BFfLmHvd0n2ufc+UfVT1OrxfiHGAVIOUxdVGDRkZN14/
	 kqHZAr2qLDwEcE09ifTFQq8hthHQv6YQV4VwGkmONPvV4JeXmhnu06np2stjS4JZ/a
	 clyD4+spzNXVyQpSQM4pjoqUrRKl8LqAc40Kl03T/jm+X68pztnPvou1830Kkm4eEb
	 anXUMAUU3Y4h62Onam2SP1zMDZIhc6woU9z1y6wOj/Fl7qvv95TCgcQzt6ts7hnFeu
	 CxfOzakmiO7mg==
Date: Mon, 1 Dec 2025 10:58:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Zqiang <qiang.zhang@linux.dev>, void@manifault.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix incorrect sched_class settings for
 per-cpu migration tasks
Message-ID: <aS4BfaIx6x8aRllk@slm.duckdns.org>
References: <20251201112540.5119-1-qiang.zhang@linux.dev>
 <aS3_u1upYCkb3qzT@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS3_u1upYCkb3qzT@gpd4>

On Mon, Dec 01, 2025 at 09:51:07PM +0100, Andrea Righi wrote:
> Good catch! It looks like we had this since the beginnig...
> Maybe we should add:
> 
> Fixes: f0e1a0643a59b ("sched_ext: Implement BPF extensible scheduler class")

Oh yeah, already added that.

> In any case, the fix looks correct to me.
> 
> Reviewed-by: Andrea Righi <arighi@nvidia.com>

Will add this. Thanks.

-- 
tejun
