Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F733B895A
	for <sched-ext@lists.linux.dev>; Tue, 24 Mar 2026 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774377963; cv=none; b=tmgyCESbE4XBu8vwepsM5WuakKETKcnB9hCP7M/9+VHTelPMuEawj6tRM3S0LCuZFlpEU5/caEXErKpPMwteFys7ts4L17RaFqyyO8BJgFv3w92RXxFW1BTJQjusQ2q3DILikWcrt1KMiSo+OXE4u2Qx2dfVL6bqGN5NmWlSqbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774377963; c=relaxed/simple;
	bh=y+wo9iDBeS0npMhD30rCCyek5oK7q7whGhlUCHN1HNg=;
	h=Message-ID:Date:From:Content-Type:MIME-Version:Subject:To:Cc:
	 In-Reply-To:References; b=pvkJV5HoA2hSTEsJ592vUxuvDTt1sKQgkATn6etRr054KMy1FNvdexZafKGE+7pZXaDrMRa2tfRrlh0oC4o7UN5p/fgtf1q36hN2xZd3ARoY8mCWCOGieeJgjPC0rT4Bk5kGrELVWZ0xOztqbg0bXl+kUhNg3wpXpGyPiUj7aSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oWZcQ1ED; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWZcQ1ED"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2adff872068so19837385ad.1
        for <sched-ext@lists.linux.dev>; Tue, 24 Mar 2026 11:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774377962; x=1774982762; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:subject:content-transfer-encoding
         :mime-version:from:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+wo9iDBeS0npMhD30rCCyek5oK7q7whGhlUCHN1HNg=;
        b=oWZcQ1EDVjv2GqRZDG2kCPPE6avsjntSXn95xENzFQV0DCId62AQdJYAzQxHiWTcGq
         Kvf/+xFo6xfyS1FCg0i8N3wguaoDgr/D+BBvvz1/CUtBAlxyNJSwMbzQeZq3cPCQOGJl
         GV7HencUm9TVenXDtkHmgKRDsBvTm2zz3+TZAKr5VkS8S+Vlq/lWnIDsWcG1cAj8i6St
         kbi+HT3F6w7EbsuDITpX6IpvjTkpxyFC5r8genFH/ONdq/60ZP0226Arkt5RaUaG38Eo
         SI4ZXLea9mzXZD8pW1ePQhb17wuJhmbBAT7sgyuOYBU7zJTL223Ig8/Q4KSoRLCOj9Ug
         bWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774377962; x=1774982762;
        h=references:in-reply-to:cc:to:subject:content-transfer-encoding
         :mime-version:from:date:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y+wo9iDBeS0npMhD30rCCyek5oK7q7whGhlUCHN1HNg=;
        b=KByuA8vttjHy5ah3lM4yuqbfmXC+hKUS4wVZpaqje/IWqDnSSRPpYgoXU6SebvgpSN
         NX4reLt5bFj8xut7osi8r5bhERaciy+3P/nBEvpcAqgytisMJKsmqrgG9fTO/A8B9HUq
         27QkWHVeyg/+CJMtZCErC009lRcc2BP4Ao7T8+vElDQG4ek4WazTNO5vYW34BUBPUAbb
         s0gaA8njt5/fz0RyjkEGN0mYLGSIshKbtrp/+iXROeqylLH5DR93h87tFzj5kHtccdYO
         dS1Yp9wcAsljcpUxt8nswgODIPM5GNJhAhUoYbQfOVHazzZ9ksKVEUI01ZnsQE9H5kg0
         ODLA==
X-Forwarded-Encrypted: i=1; AJvYcCVkalmDeuWYAt90xPjV+HqRYL0QdZN/AeaYZnGaVNPCELkSEs/P2d4p1GULZbsOmUdeEosTiJgGVkc=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzkd4qCF2slu7IXtgXBA+J/lkEThyrap7lXSnUmAY8D/osSsWv4
	gqPsoscv1ufdGevJYb4iAXebOKgva+nks5LE4dMGUjvszLy45prCbs/s
X-Gm-Gg: ATEYQzw2dGFK+RgrDPznH9VlRys9Huu8mOQRqWfrYcSdJnQUt7OjmO9bO/bTY9cCLCB
	ywczAywWW+1cbPGBT1zSS0jptqlb9e6Q96df59wAFLLU65GZOJEvy+kMNLqE6GFGK/lEn+1FyRm
	j1L2N9kl3G8PzN231Gslz/cSt6CvisgwL2B5YItQ79n1cetp4YnleFutzUXbg6n82VN5ygXbxHS
	tMhyDqSwVTFpR8M5gCrpo0GK9Kk8Q15qtdnubKoU/yHEPXKhBu3TmQRstWlfzhSMNS0F2OLP38M
	qWyCb6+uGXTKr9gDSYNlvy9no0dv+tcqySuYBAkG1dUtmw1I1w/pjbAKY86d7GSMM08kFcplIqz
	zxJ8o68oTNkSTx0Smvo7o6lhRHg5afVAZ0oaI5jxIiJZ9l4g5ATwzjixsD3yZYXkFeKBrHUEO7I
	8C/O17p9oDrUaP/dCokq47Qi7I
X-Received: by 2002:a17:903:1b4e:b0:2b0:6895:5535 with SMTP id d9443c01a7336-2b0b0a8c433mr6729765ad.33.1774377961993;
        Tue, 24 Mar 2026 11:46:01 -0700 (PDT)
Received: from [127.0.1.1] ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083656f65sm221497615ad.45.2026.03.24.11.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 11:46:00 -0700 (PDT)
Message-ID: <69c2dbe8.170a0220.226f48.721e@mx.google.com>
Date: Tue, 24 Mar 2026 11:46:00 -0700 (PDT)
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
Subject: Re: [PATCH] docs: Document pahole v1.26 requirement for
 KF_IMPLICIT_ARGS kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: 
 <CAADnVQLbtuD=7mtGZFR25ULhjZ-3ifBpkyRcqu9jPSd2Mt3fBw@mail.gmail.com>
References: <20260324062028.2479059-1-suzhidao@xiaomi.com>
 <CAADnVQLbtuD=7mtGZFR25ULhjZ-3ifBpkyRcqu9jPSd2Mt3fBw@mail.gmail.com>

T24gVHVlLCAyNCBNYXIgMjAyNiAwODoxMjoxMiAtMDcwMCwgQWxleGVpIFN0YXJvdm9pdG92IHdy
b3RlOgo+IEkgZG9uJ3QgdGhpbmsgdGhhdCdzIHRydWUuCj4gQXQgbGVhc3Qgd2hlbiBpbXBsaWNp
dCBhcmdzIHdlcmUgZGVzaWduZWQgdGhlIGdvYWwgd2FzIHRvIGF2b2lkCj4gcGFob2xlIGRlcGVu
ZGVuY2llcy4KPiBQbGVhc2Ugc2hhcmUgZXhhY3Qgc3RlcHMgdG8gcmVwcm9kdWNlLgoKSGVyZSBh
cmUgdGhlIGV4YWN0IHJlcHJvZHVjdGlvbiBzdGVwcyBhbmQgY29kZSBwYXRoIGFuYWx5c2lzLgoK
UmVwcm9kdWN0aW9uIChVYnVudHUgMjQuMDQsIHBhaG9sZSB2MS4yNSk6CgogICQgZ2l0IGNsb25l
IGh0dHBzOi8vZ2l0aHViLmNvbS9zY2hlZC1leHQvc2NoZWRfZXh0LmdpdAogICQgY2Qgc2NoZWRf
ZXh0ICYmIG1ha2UgLWokKG5wcm9jKSBMT0NBTFZFUlNJT049LXRlc3QKICAkIG1ha2UgLUMgdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvc2NoZWRfZXh0CiAgJCB2bmcgLS1ydW4gYXJjaC94ODYvYm9v
dC9iekltYWdlIC0tY3B1cyA0IC0tbWVtb3J5IDRHIC0tIFwKICAgICAgdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvc2NoZWRfZXh0L2J1aWxkL3J1bm5lciAyPiYxIHwgZ3JlcCAiZnVuY19wcm90byIK
ClJlc3VsdDogMjMvMzAgdGVzdHMgZmFpbCB3aXRoOgogIGxpYmJwZjogZXh0ZXJuIChmdW5jIGtz
eW0pICdzY3hfYnBmX2NyZWF0ZV9kc3EnOiBmdW5jX3Byb3RvIFszODJdCiAgICAgICAgICBpbmNv
bXBhdGlibGUgd2l0aCB2bWxpbnV4IFs1MzgxM10KClJvb3QgY2F1c2U6CgpUaGUgS0ZfSU1QTElD
SVRfQVJHUyBtZWNoYW5pc20gcmVxdWlyZXMgcGFob2xlIHYxLjI2IGZvciB0aGUgREVDTF9UQUcK
Z2VuZXJhdGlvbiBzdGVwIHRoYXQgZW5hYmxlcyByZXNvbHZlX2J0ZmlkcyB0byBkbyBpdHMgYnRm
MmJ0ZiB3b3JrOgoKMS4gc2NyaXB0cy9NYWtlZmlsZS5idGYgZ2F0ZXMgZGVjbF90YWdfa2Z1bmNz
IG9uIHBhaG9sZSA+PSAxLjI2OgoKICAgICBwYWhvbGUtZmxhZ3MtJChjYWxsIHRlc3QtZ2UsICQo
cGFob2xlLXZlciksIDEyNikgPSAuLi4gZGVjbF90YWdfa2Z1bmNzCgoyLiBXaXRob3V0IGRlY2xf
dGFnX2tmdW5jcywgcGFob2xlIGRvZXMgbm90IGVtaXQgREVDTF9UQUcgQlRGIGVudHJpZXMKICAg
Zm9yIF9fYnBmX2tmdW5jLWFubm90YXRlZCBmdW5jdGlvbnMuCgozLiByZXNvbHZlX2J0Zmlkcy9t
YWluLmM6OmNvbGxlY3Rfa2Z1bmNzKCkgKGxpbmUgMTAwMikgZWFybHktcmV0dXJucwogICB3aGVu
IG5yX2RlY2xfdGFncyA9PSAwOgoKICAgICBpZiAoIWxpbmstPm5yX2RlY2xfdGFncykKICAgICAg
ICAgcmV0dXJuIDA7Cgo0LiBXaXRoIG5vIGJwZl9rZnVuYyBERUNMX1RBR3MsIGJ0ZjJidGYoKSBu
ZXZlciBjYWxscwogICBwcm9jZXNzX2tmdW5jX3dpdGhfaW1wbGljaXRfYXJncygpIHRvIGNyZWF0
ZSBfaW1wbCB2YXJpYW50cyBhbmQKICAgc3RyaXAgJ2F1eCcgZnJvbSB0aGUgb3JpZ2luYWwgcHJv
dG8uCgo1LiBSZXN1bHQ6IHZtbGludXggcmV0YWlucyB0aGUgMy1wYXJhbSBwcm90byAod2l0aCAn
YXV4JykgZm9yIGFsbAogICBLRl9JTVBMSUNJVF9BUkdTIGtmdW5jcy4KCkJURiBldmlkZW5jZSBm
cm9tIG91ciBwYWhvbGUgdjEuMjUtY29tcGlsZWQgdm1saW51eDoKCiAgJCBicGZ0b29sIGJ0ZiBk
dW1wIGZpbGUgdm1saW51eCB8IGdyZXAgLUE1ICdbNTM4MTNdJwogIFs1MzgxM10gRlVOQ19QUk9U
TyAnKGFub24pJyByZXRfdHlwZV9pZD0uLi4gdmxlbj0zCiAgICAgICdkc3FfaWQnIHR5cGVfaWQ9
Li4uCiAgICAgICdub2RlJyAgIHR5cGVfaWQ9Li4uCiAgICAgICdhdXgnICAgIHR5cGVfaWQ9Li4u
ICAgIDwtLSBpbXBsaWNpdCBhcmcgc3RpbGwgcHJlc2VudCwgMy1wYXJhbQogIChubyBzY3hfYnBm
X2NyZWF0ZV9kc3FfaW1wbCBleGlzdHMpCgpXaXRoIHBhaG9sZSB2MS4yNiwgcmVzb2x2ZV9idGZp
ZHMgY3JlYXRlcyBzY3hfYnBmX2NyZWF0ZV9kc3FfaW1wbAooMy1wYXJhbSwgZm9yIHZlcmlmaWVy
J3MgZmluZF9rZnVuY19pbXBsX3Byb3RvKSBhbmQgcmV3cml0ZXMKc2N4X2JwZl9jcmVhdGVfZHNx
IHRvIDItcGFyYW0gKGZvciBsaWJicGYga3N5bSBtYXRjaGluZykuCgpZb3UncmUgcmlnaHQgdGhh
dCB0aGUgZGVzaWduIGdvYWwgd2FzIHRvIGF2b2lkIHBhaG9sZSBkZXBlbmRlbmNpZXMgLQp0aGUg
aW1wbGVtZW50YXRpb24gY291bGQgYmUgZml4ZWQgaW4gcmVzb2x2ZV9idGZpZHMgdG8gaGFuZGxl
IHRoZQpuby1ERUNMX1RBRyBjYXNlLiBCdXQgdW50aWwgc3VjaCBhIGZpeCBsYW5kcywgdGhlIGRl
cGVuZGVuY3kgZXhpc3RzCmluIHByYWN0aWNlLiBKb25hdGhhbiBDb3JiZXQgc3VnZ2VzdGVkIHJh
aXNpbmcgdGhlIG1pbmltdW0gdmVyc2lvbiBpbgp0aGUgcmVxdWlyZW1lbnRzIHRhYmxlIHRvIDEu
MjYsIHdoaWNoIHNlZW1zIHRoZSBjbGVhbmVzdCBmaXguCgpTaWduZWQtb2ZmLWJ5OiB6aGlkYW8g
c3UgPHN1emhpZGFvQHhpYW9taS5jb20+Cg==
