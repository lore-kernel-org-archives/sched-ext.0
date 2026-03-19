Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96754238C03
	for <sched-ext@lists.linux.dev>; Thu, 19 Mar 2026 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903896; cv=none; b=DbjYDTr/UXl/0s4ctJ41qadyD3OTK/DwbU5l6Cgm2guSocnuXZqjFCKVi+JqIPbYXpjeKFWX2K0WWItVZfKAstHe9DVLdlFH1hZ2WYl/mQCbiGUIlMRKhIZXoQgLOsL1C4xdF55AD3tLYE8IqPrzJeqPzQS5hRfSqHNqgcywqXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903896; c=relaxed/simple;
	bh=fjDl6eUCxxDuKbCK9i1s5Op0J66a0Do/SQRMZl8mfRc=;
	h=Message-ID:Date:From:Content-Type:MIME-Version:To:Cc:Subject:
	 In-Reply-To:References; b=KA9CB9sQPyUFmidWMmoqKn3dG/7g7Joj69lk88ngv2zVq/OMIcIXVGQuwMCgll4i/KoAX8+QH8den6F0SGuksKlocl8g+IWXpVDg0ieWdkJSSsxb5E1Bz9cc3hNoHd2O2oJbORZD+Iqz7o68oPWbuunWRYt63MDb4qDulqQtXLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZT6UaM5+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT6UaM5+"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2adbfab4501so2561595ad.2
        for <sched-ext@lists.linux.dev>; Thu, 19 Mar 2026 00:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773903895; x=1774508695; darn=lists.linux.dev;
        h=references:in-reply-to:subject:cc:to:content-transfer-encoding
         :mime-version:from:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjDl6eUCxxDuKbCK9i1s5Op0J66a0Do/SQRMZl8mfRc=;
        b=ZT6UaM5+Wlh/nc1LFxCuaJHUy4u+A/ZIyhfE6CkeniHz4KTLvrZkNHxhzrWCQ4u/97
         3CyQbmI30F+ZpyTb1dRkLySTRKfq8UtvRLYIP60fOEi92gZ+2xBydtnV35rOYUr+Flf/
         Y9XiAs7B/LLTKcd6MQWRoxMl9hiup/kCeapicAths1Vr1DF6lSutEtsCdbNowDcJuRz4
         kvobqlsi5neHkOqKkC3H9DgDJwcE3086UoU4xsaRC/xSABUPikO/jvCg5t99ajPC2Gig
         OFxJKp7Uir2s1WZDojg8oJAseE97qLx2+gkoFIsXHY1faafMos6QkureUnD2IuW/GKU3
         Zn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773903895; x=1774508695;
        h=references:in-reply-to:subject:cc:to:content-transfer-encoding
         :mime-version:from:date:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fjDl6eUCxxDuKbCK9i1s5Op0J66a0Do/SQRMZl8mfRc=;
        b=YTnbniHnTp8S8ObGU9Z6zFgmbbjVULLS9zG90WYc5SxR787JPlJBjwzy8Wj9jZXRZA
         SCJGYBv0UlbedMMQPFGMWGw0Pm0coWrdFH3qxaQN2z7BuhuCUFyxR/m8P4dN0DYU+Pal
         6L0im/Y59A8Icok4c1Zi2nMp6yI651Is5lTnDTbbHO+MX547GZCEI84lbNu6dQv9sEMW
         oF9nvQYlXUls1e9fmMR2X8VGvNiU+qy6Fkh6yjchPo5UqNzCc5ozITlhUnhYxYt0xstz
         86izx6+pFIEZCFG4RqClhA2TcPh5FZVwEey8YWOOKFZq3IJouUmPf5txcMKGKfhwnDV7
         JbYg==
X-Gm-Message-State: AOJu0YzClsyzJr0lrPL9KOhAeLAZR5qQ6Xy3Wg7himLnzETXjfwyX9Lq
	et/DHa+M1D7A9aWs3QnVxgcwsP90NZ3pg3imeWyPnQSfYW+3rZB3qMJF
X-Gm-Gg: ATEYQzwCQCmu2F7BvFkZkoRsEuYmPlqsSVv6XbIm3DJRRIHMszb7ZPR1i7vOGSZWbLP
	3/Wvw3J9GU0Q2KNK275vDMerqDq6cb1YFHq8uhONUdgRv+5n7QusZhxfVh/yJDJ6osPISU+v5Ol
	5XEq1kL6wdnNg8Xjvd7U+anfK72CYkC4d8WE40zK1fQHDn5letozitqVcNYQkxn5pQd9azFsXd/
	udwTpEWSQFgbi0CTrg6t8Z/15NMELccUowx+FmUCH38sWKKBFLTvFZ+3WspJqKdszwCoDfxTbea
	6KHbnGGBquHMBYrrOt/bB9DoiDAoe0AwZwqIH55x2xUHVY6F6/v4036iUjFbvyDim2uVqoHVt4M
	sEMc+sfVK2SrLOWkx5zVWqTBuHzfjx2HWhyfx1nX+0GsVLimVwbVghwUut7conP3srT5Z8102gX
	IZ5m8SXhZEXcSUh93sGuGypbs=
X-Received: by 2002:a17:903:230a:b0:2ae:aafa:ec95 with SMTP id d9443c01a7336-2b06e2fbf7cmr64796805ad.11.1773903894913;
        Thu, 19 Mar 2026 00:04:54 -0700 (PDT)
Received: from [127.0.1.1] ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e604e7bsm65005415ad.63.2026.03.19.00.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 00:04:54 -0700 (PDT)
Message-ID: <69bba016.170a0220.92228.ab0c@mx.google.com>
Date: Thu, 19 Mar 2026 00:04:54 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH 1/2] sched_ext: Documentation: Document events sysfs file
 and module parameters
In-Reply-To: <abubiaubvpc2GqNH@gpd4>
References: <20260319053026.447892-1-suzhidao@xiaomi.com>
 <abubiaubvpc2GqNH@gpd4>

T24gVGh1LCBNYXIgMTksIDIwMjYgYXQgMDc6NDU6MjlBTSArMDEwMCwgQW5kcmVhIFJpZ2hpIHdy
b3RlOgo+IFRoZSByaWdodCBwYXRoIGlzIC9zeXMva2VybmVsL3NjaGVkX2V4dC9yb290L2V2ZW50
cy4gQW5kIG5vdyB0aGF0IHdlIGhhdmUKPiBzdWItc2NoZWR1bGVycyBpdCdzIHByb2JhYmx5IHdv
cnRoIG1lbnRpb25pbmcgdGhhdCBzdWItc2NoZWR1bGVyIGV2ZW50cwo+IGZpbGUgaXMgbG9jYXRl
ZCBhdCAvc3lzL2tlcm5lbC9zY2hlZF9leHQvcm9vdC9zdWIvc3ViLTxjZ3JvdXBfaWQ+L2V2ZW50
cy4KCkZpeGVkIGluIHYyOiB0aGUgcGF0aCBpcyBub3cgL3N5cy9rZXJuZWwvc2NoZWRfZXh0L3Jv
b3QvZXZlbnRzLCBhbmQgdGhlCnN1Yi1zY2hlZHVsZXIgcGF0aCAvc3lzL2tlcm5lbC9zY2hlZF9l
eHQvcm9vdC9zdWIvc3ViLTxjZ3JvdXBfaWQ+L2V2ZW50cwppcyBtZW50aW9uZWQgYXMgd2VsbC4K
Cj4gTWF5YmUgYGBzY2hlZF9leHQuYGAgbmFtZXNwYWNlPwoKRml4ZWQgaW4gdjIuCgpUaGFua3Mg
Zm9yIHRoZSByZXZpZXcsCnpoaWRhbw==
