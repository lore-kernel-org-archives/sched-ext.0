Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D567D3806D7
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711032; cv=none; b=srtuQpSuSPPhOvdOTnhmbqIsEodY981NKst1NHDvkKbsL2BtDPyB6ti09+gVl3Ax2mW8TKjXnhnI0T3D86MtxIcYRutvUr60Qjue95LAxa3MHGZ+NUbciqE9pXoZejl90KPzbvMzpQK0Qs+44WyBkFzr+YXJfoPL82PEa9xMAo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711032; c=relaxed/simple;
	bh=fKtx+l1oHOZNTCM/j46NLi2wxexlleELoSfRE/hgiyI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=P6gHrizqRsBcmhbb4RbDvMSxqwl3jO3I4cg9sJbBZl5JNiu1SvXKu7SRMR2P8KEQSCG2PQ/+0vbuWMNZB5EyorA6HVhCoWS9KBRa/ykvtY9C/gjP5WzbyoNKdtqQEdMX1gwtkp+4VByT9k/qmRFEiP+gxh9gw5r8fA5pkKAjmxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AI7UxoOy; arc=none smtp.client-ip=74.125.225.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI7UxoOy"
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-493ec85730eso1472305e9.0
        for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 12:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783711029; x=1784315829; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fKtx+l1oHOZNTCM/j46NLi2wxexlleELoSfRE/hgiyI=;
        b=AI7UxoOyNP46yIs1FclB2ScfHgAMHjr7nos5O4EIVa87oecNknNOpztqP41aSC4f+j
         Xav8fWBzozkWuuuYQ/7k/+KMYbDxKtZgQRAh/oVCZGMLObEEeS7AeegriuMt2XZQBvFG
         hkqVuhxnudrfx9fflEMf2E4OftyFEYRjBmNf+E6bIYF2i/ksp0k2HzpouTXmmvahjgGZ
         rfWfkLzQ3Fps4Py2uCSzSLsB5ITYVFsTLosRoxSLcteBaUlgVm7C6k8S8GbcjCaghsDe
         55/0kFc1GHrFay7ZdusoJNC+25WMUto7JGaxryjlgcxu0Imfm+yTWsJv33M7gAYQ07sj
         NikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783711029; x=1784315829;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fKtx+l1oHOZNTCM/j46NLi2wxexlleELoSfRE/hgiyI=;
        b=pdZ+4+cVCApS/z8aNCwBd7t2Sh4NiKloYC63UJnGC6csRQbv6x11haYtVVDBpvcz2t
         Fhpgh0G921OGYPwe2j7Pry4l/gLk7iZi86rzY6im8qrOa7iR0pn/fdNMkaR8iC8X+OQo
         l0hOU13hJVvE+GcT+hH952AKLEE/AVF77V0m069DPDbbWt7aH+4/RpfZXiCpBgc7byO6
         zzoToR5ZksmPBLtVaFgCNAVbGX08TI4JeEzZoa7Z0ue+bvNHIuHKzv28B6hpZeoYWQvu
         JfMK95XWLRHymzwPYL9bwa8Lc5C8dxkQpRVg04nKh6CU9orBhOQaVF/oRd30ulTXkdVt
         Yatw==
X-Forwarded-Encrypted: i=1; AHgh+RqTDaBlhbAvJhpXvHq9qPCBGnfU2EAT+n0pzlCkEkP2bF4c3hF7cRfl6txMrKkCZHLXpCFgAJcU6vE=@lists.linux.dev
X-Gm-Message-State: AOJu0YybEolml7jZt/NAa3kYZ8PeV4s609UVhK+h12bqV5BdGusJshWD
	1Nyv3UGMpfJ+9am63bV34316I99O7a137i7hp6A9VXR753+UzQsnQoCO
X-Gm-Gg: AfdE7ckrxrzjXLtIIIH8dHCJzFZjhgbzwGcIryn1ANiqR2Ibhic3X/jOLdYh+dgIrfz
	Kpp6ugK8kpq6cF614NTFC+oNMWLIzTTFvyhduwcKjqDP52zi47TU5im3nYtgW7lBPcS7CzfbEl5
	An0em8O/YM2eU9h+liROAS1phHhgBWr8N3KlQpsPZA5cxdKb6R0Nri5xZLi5iDyvuT8aj7VZdPd
	eK564xKCQar6INTb1WwwOChMeV5+xbXYct95YoYHhBkmJJJBFZxnSIZ5gI/lzKVYscx2uNqwK63
	MN1GIsUeCy7TfPi0bKkT1qxu7FUUrtk5+c8gq7n17tlM4lc8bYVC7gC/IJTz34M0Qs8njoqrJ73
	M44wLJ0NHSkxc5EANdPV87yDaY0C9pFWnfCSmB0eBG8Tl2hRZZIZNvU5on1Yz9eRYWQdkLI3Pp2
	k6hV3sm3bjYAqWt9HvUF8vCzXUlIqelCqYUZXtU78QxPJA7iwJIvQpSLNDvRYrNUF9btTQTHOFy
	onbjZECFMlDJ0g7DbSfxdaVI0kopWo7EgZraHvwuIp4XZzFKNjgDgQ=
X-Received: by 2002:a05:600c:3f06:b0:493:be13:98b with SMTP id 5b1f17b1804b1-493f8820923mr1197835e9.23.1783711029096;
        Fri, 10 Jul 2026 12:17:09 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f16cfsm160683635e9.12.2026.07.10.12.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 21:17:08 +0200
Message-Id: <DJV4SE3UC9L5.2MM3IGLHLQICW@gmail.com>
Cc: <tj@kernel.org>, <void@manifault.com>, <arighi@nvidia.com>,
 <changwoo@igalia.com>, <bpf@vger.kernel.org>, <sched-ext@lists.linux.dev>
Subject: Re: [PATCH bpf-next v3 0/2] bpf: require an owned cpumask for
 bpf_cpumask_populate()
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Nicholas Dudar" <main.kalliope@gmail.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0
References: <20260709182800.2037938-1-main.kalliope@gmail.com>
In-Reply-To: <20260709182800.2037938-1-main.kalliope@gmail.com>

On Thu Jul 9, 2026 at 8:27 PM CEST, Nicholas Dudar wrote:
> bpf_cpumask_populate() writes its destination with bitmap_copy() but
> types it as struct cpumask *, so the verifier accepts a borrowed,
> read-only cpumask (for example from scx_bpf_get_online_cpumask()) as a
> writable destination. Fix it and add a selftest for coverage.
>

+To Emil

Hi sched-ext folks, this fix looks good to me and on cursory look, apart fr=
om
potential signature change which may require some adjustment to casts, it s=
hould
not break existing intendended usage.

Could others confirm this? Thanks

> [...]
