Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5C724BBF0;
	Wed, 29 Apr 2026 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447069; cv=none; b=ZMIvX12LNfbfriWDgLZTy/V5t2ojACfMDk0sFWbNG42bO9esIz3rLypd4QjkmRepwfptQ5YcZKhRxuIcXMW+eEiu0gDuuj3jy0zqgjgK9CtufhOKq4iCp+Qdor84MuEQ0bDviIsAN4ZAxF5TF8qZutKpLI3P34/I2c6oIT57OaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447069; c=relaxed/simple;
	bh=LJrYFtyL/gxpwCr9Yl9aCRvZ9aAMs1/nB1vMIAMDoPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ojUFm5CbGmd4uaIkmXLmN+CQUsCkZo/yAlf4QuYy52Mhyf0kB95vTMbC+f3YruG+TbIfQhP3GKfOdZcpIlOJIyyf5hNtxmwewM97NQniAuJHR9dHqotGQBFXBMOuKL4awN0bw3TwD7/IrAs+psnt6j/l8tpwg8v4LttiDCsQuFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pU1xUJTE; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pU1xUJTE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LJrYFtyL/gxpwCr9Yl9aCRvZ9aAMs1/nB1vMIAMDoPM=; b=pU1xUJTEwLOIEnBZpK2gmp+HOJ
	kADfFpjS6XjlPrWtCYbWQ6Uv2punkv4alcASUI5obz3VaWr2mS3RlRJIxEzNCCi/3FY3HF2Y2rL/j
	moGwXq/LuPIf4kf44v2g5BmVq0BofNs9vJSr4CXqcppkEWWW8BxUk3zEbLhvvvXVgUbhKimnjewtg
	RghKUMVpO4WteY/F918Nd6ZTATJTTcA3g4HguSxr/94SqJszKqKEbIHgo1YfuClo3/8oP24M8j196
	Y+bSx/6fCgGZ3ZL23lpJ/Padd89U4nK8Rf3pAM6v/Nenn02vEEmX33+JA+Lj6LAg/8hxK5SWNjO5P
	DP6qWQBA==;
Received: from [58.29.145.179] (helo=[192.168.8.203])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wHzAw-003mIo-2c; Wed, 29 Apr 2026 09:17:37 +0200
Message-ID: <8633fcd7-fd31-4af1-b578-2439a69318df@igalia.com>
Date: Wed, 29 Apr 2026 16:17:31 +0900
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] sched_ext: Dump the exit CPU first
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, arighi@nvidia.com, kernel-dev@igalia.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260429060726.359024-1-changwoo@igalia.com>
 <20260429060726.359024-3-changwoo@igalia.com>
 <afGvufr6kLYiAbhm@slm.duckdns.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <afGvufr6kLYiAbhm@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks, Tejun, for the review.

On 4/29/26 4:14 PM, Tejun Heo wrote:
> It's a bit mixed throughout the code but let's use s32 for cpu. Otherwise,
> the series looks good to me.

Sure, I will post the updated version soon.

Regards,
Changwoo Min
