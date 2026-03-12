Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27A73C3C0F
	for <sched-ext@lists.linux.dev>; Thu, 12 Mar 2026 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320256; cv=none; b=XOuj4/YBYxV7QNGOvnjrt3K+5FvQ+c50IAp/AIW/EmZQj152sccV3PamFHdB/45+iT/lUfizUZhavShiXhXpKa/7VtR54bNswSoHtaCcvzSPLlDr0suk0tYLG9HIc71h4vxSqml845cENJV4F81Z1QrT57UdALOOU4uJEN1eY1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320256; c=relaxed/simple;
	bh=Rr1jkAP22lZkLvo3o90a9fRSWh9+kilNKtAarSScWFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8iLYNc38LRyuAioF1Zr3IXCcJ827DKOuO8rCt7LTMoR59Fn39gEdKSn66EzdfmFanmsB2rNHNw4eLs4YP0n/9P5200GplH5Rm84LkjEIRH+BCoiIoxkblQUOEXBcjx8XyGeBmhYVR6Ov2uWnIooo3WT9+eL3JkBzLcWexzoivI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nVIyHmtx; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nVIyHmtx"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50915e14cf6so7425531cf.3
        for <sched-ext@lists.linux.dev>; Thu, 12 Mar 2026 05:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773320252; x=1773925052; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J1SF1XBHkHR0j7NZVucv0LxpGoGXl67PUefLsfwpAbo=;
        b=nVIyHmtxjvuHU2WooaPvVIJyWMLIavFAbnfF3EMwTyeCe6Jwh16Cc/2X5oR5JCY7xN
         Sa9SHT7wbmq/tQso5EeKa3cB0FFKwnbLFKVySuwjtZIgkFpm5Y5/y1sH3IN0ZjxujoTs
         cvi3DS59f6x8zSGKa30UG+1YXccClF6XKkfhX27a2mQ1iHcgjt07iiTvNDOusfoyyb4L
         tHa/jwISMxQfIP0HxYaAgcwqVI4491rQ8DHPUkX9vV3Vz2aY8KPu88HffHi/BD6zwcm1
         p6rnPX+s1J3sQAUNk2MURk7ASeBgJODP/YrfH9/YU9OQIT+mFcp1uUjG0i3nLTckdXon
         4D3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773320252; x=1773925052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1SF1XBHkHR0j7NZVucv0LxpGoGXl67PUefLsfwpAbo=;
        b=U5Qt1PHiwwpTZa5nj4PzKKJcxs8DdK3HOgi/e+o6PrmFXaXWFNhYUOcLZzs87qIvhJ
         sNn3yltA3NQQrm0AAaZooCbI5L7Bn1IrDZIQ6A0MKevJWS8ha9CwaOd3wdH/Rjd107e8
         iSRam6F+wazqy8eW8bswaAukebhMWqe9ySa658oZecpAGh/gmPVV6z4aZaHBfGs03oMs
         9YXqEU0JjcYTEiFOaS4hjjQRAwBLeVLOZLGL0EySytFLmGVQHgg2Zq3Mlkbm4SH+k/7J
         SNdG9thuhHr0IXlMNppOJVpJxsZSZmy/zRq/hXSHohiTnPmZ+OySVDZSRgE0T+i+sq/S
         ojGw==
X-Forwarded-Encrypted: i=1; AJvYcCWSYybaIKbH9yjbXtEC7dk8WwQtK0KPxfgeX6dbYeCMaWZfwhXVRApZL5sb/Bu+HyTkoEyOi9K0xn4=@lists.linux.dev
X-Gm-Message-State: AOJu0YzdEh8SMCmKo+MHLU7YhNXMoyiguWKmdcsNOb/AMI7vyqywFh+M
	39UAl7AU1xzQpEZfKWHjABasKe2lsxNUsa9/E9EW/ccNMECVC3iYIeLuonuIff4xTUg=
X-Gm-Gg: ATEYQzxlOHHufVRan9TMpukQaRAK7EaaatFoLnIlvwbbBfLfL22QjVs/94utRD5b5X+
	o+qI6SQJDdzZNRdHQdvTcgMP7/Vw9ZpX03GPlIrbzCbDFJ8wpmJVFzJHFwV6pZ5NX1dp0HkSG2R
	ZYXRldubD9/xw22T/kyKanUV0aQ5AlLh3pajKoX8bTiMf6xEd+H7OXoA8YU9QkGHvj19GAA9vdL
	6m8pZC+QO3oVGV/PxFxTgPOtbrgCSZL97SsyCP6bdLorATw7gI4D7FFO3LpqdUpCtJutOXLyP8y
	p50OEDeojTTsd+DgwA/ONkLlHgUIUghhPKrVmZuQ1YKTxyl/mdCSoUU3Zw6LftRr2vIWQBrfEFu
	CFzo8GO7KXOoUNxVc60yDST88vaM8sxnNIOsSSzigyTl7O9bopHjAOrU1i4Fb9dkTwixkDZ7Ip9
	chs6gcQ53/NadXJRcF7usOFj3fFKem4GSU+KmDbtvbo02tsBQ98X9onLeD06IgBfH8/86t/QXhq
	Bz6Tp2K
X-Received: by 2002:ac8:5d4d:0:b0:509:cbc:127b with SMTP id d75a77b69052e-5093a1bd58fmr77950521cf.60.1773320251710;
        Thu, 12 Mar 2026 05:57:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65bd318fsm33341196d6.8.2026.03.12.05.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:57:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0fbW-00000006fKD-1POa;
	Thu, 12 Mar 2026 09:57:30 -0300
Date: Thu, 12 Mar 2026 09:57:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org,
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org,
	ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev
Subject: Re: [PATCH 00/61] treewide: Use IS_ERR_OR_NULL over manual NULL
 check - refactor
Message-ID: <20260312125730.GI1469476@ziepe.ca>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <abBlpGKO842B3yl9@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abBlpGKO842B3yl9@google.com>

On Wed, Mar 11, 2026 at 02:40:36AM +0800, Kuan-Wei Chiu wrote:

> IMHO, the necessity of IS_ERR_OR_NULL() often highlights a confusing or
> flawed API design. It usually implies that the caller is unsure whether
> a failure results in an error pointer or a NULL pointer. 

+1

IS_ERR_OR_NULL() should always be looked on with suspicion. Very
little should be returning some tri-state 'ERR' 'NULL' 'SUCCESS'
pointer. What does the middle condition even mean? IS_ERR_OR_NULL()
implies ERR and NULL are semanticly the same, so fix the things to
always use ERR.

If you want to improve things work to get rid of the NULL checks this
script identifies. Remove ERR or NULL because only one can ever
happen, or fix the source to consistently return ERR.

Jason
