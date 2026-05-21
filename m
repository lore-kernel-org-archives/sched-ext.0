Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C55537B400
	for <sched-ext@lists.linux.dev>; Thu, 21 May 2026 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779356576; cv=none; b=QtgItyP6JbtD5Q6AwPK8e67y79MEGTTRJUenGCpAdNn58jp+BUXoKLPt7FMlUQUNO2hWh43Yo+HgKfqqf955/8j3J/jTs0zJwRKOoFMSxW2ea5HO1cketa+NsYRi//2yM1WkaJbM3pqNnIhEBYxZskP61EdATvKZvo7DZxjBX7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779356576; c=relaxed/simple;
	bh=guB4lS9kyi78JK5do5dUd/XbsnRUSSrOptJveHhaR1s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=M8AYEO5mFiQOVcgxmcDGo+83hRWUB9v9qT0bNg0gFqaub/tvIF8nGBrx0eRu4K1A63qCX4jYagj4rdtciUMNLV/YcwgoWCLEmPCef8HW2cbZdKVATXDLv4In8AfOoWOctWbrX9spmRET8bRmxXO69GJ5AKbehNs4XeRKWieWySM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l244B8kf; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l244B8kf"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-69d69fcdb44so628084eaf.1
        for <sched-ext@lists.linux.dev>; Thu, 21 May 2026 02:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779356574; x=1779961374; darn=lists.linux.dev;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Enrh790BjgIIUBfQlfWGTFeBgm0WSl+DUA/ZN6Netao=;
        b=l244B8kf1pKyrD0ehPVJinfFJLRWZmYLOZncpMlspW3Vn8XnmNMC8JkVQPsaVHNQrO
         2C1svcWMO8TdYamYsMy5Z2MVdDXSy+48P3YMU21XXGXhgZiMPel5O80AKbt+gCsXRWSI
         R+WKv2WF0Ytirm3dkYOFTVOzBCDdqgHZjgcB9yVTsHLoOfbgnjAyYKIHEAnX+1UDgcv2
         +7WrSeTjchhtGbkP5YnCXA47xDYUuRHIsVqRPP+LlPs9CQ/3kRdh4Po1zYn5s3d8aG7p
         b26UqTLqU7Lpm0783KKzZ9cZ3PGsXw+pupB5+dceMpoCqJQ/72R33y1myopbt349/kZ6
         JdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779356574; x=1779961374;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Enrh790BjgIIUBfQlfWGTFeBgm0WSl+DUA/ZN6Netao=;
        b=h5X/OvFNO9isABJ0IHCprAjwGDDgsteH79aG6jGGDFzN7obnefgZAQgis4uX+Zz2EQ
         EEHbTgFhUFn/PrjcJSbTkfekW/G6K7qdWLOl4h/XDLcU4SsYA1orsWAgpmS0BpUT3kod
         qBJ5SHO3Y2UpBg2/+dZiGModUIpoiHkOoVz4pjHq+2JzHMOj7jQk0yTmXZCrH8dNKvzu
         Hpd0zGjhg3DEI0vaEeyewbj/MJz0qf6aG7MRo0xJg6R4aBbAqNVLPQQbhhaPQjulQzZg
         FIZYFefN2MuGng+XewUtU2QHOukjVe+q4y1LHRoPHsaNmi/t0sFkAMplev2o6CIgH1br
         65VA==
X-Forwarded-Encrypted: i=1; AFNElJ+tfXDfs9LENtEAVpiCLG+oxhRzfObfztZCESHANEIi3s2iB52duaj5Vx1DxmsUnOCLhwT2FUm+fzM=@lists.linux.dev
X-Gm-Message-State: AOJu0YybPjBtIgHKpLbM3ZRURZbDREo/8YzS6J3sz/F4Uk4bCoKRdNeH
	JdAjwBo6wMNG21snV189CqZyOV02+IO0BPdnP37QbFwOCbjv/qnMTqfv
X-Gm-Gg: Acq92OEPnT8iyTgrN6RQn4kV16zrwpVYtWg+H7oiU7WlQvQVYytcon3LYEl7JwQd5hG
	ay07J2z35vFpRtenlu5ZK/Cs6FXb0CUZZuz51coj08UD5oGQPEqKvscOhFsIIUAYNpUmBNLzDEo
	oJXjifZtyWYblv6sQfUP9sXNz3Ixrcj75GzABgKVkyX+9O7PK0Y/085M9tT9VkuoJsKtzBH1Gu8
	tjJHyADESoct6TusgngyWrbZiJpKGQ1eudgIUzeQ3Isww0p+VAkzZygfKJNMIVaANu+ik+pHTwB
	LorX5X3NJCWHs3zrD0lbA/NpTJnYJihRgxok0bJqKJISHYbUjeBNPinNjYXULffXj/MEr7s4PGl
	Rrl9ws8tyEQ7Owq8F6vt6jQU1RrVP7/E/LsKzrjvgS67QStq6Ew4E00v8HshU19yqUy590AI4/6
	fyrIOW4T0E+Gw59lzCRqGbaXF/QfgbKu4f+OIHCn2dF26XaB1jE/BBtkG1iA0RNEK2ApPYGEOlH
	qmEtGlmEBadAwosMQ==
X-Received: by 2002:a05:6820:290f:b0:694:6acf:a42d with SMTP id 006d021491bc7-69d6eefa916mr913981eaf.39.1779356574211;
        Thu, 21 May 2026 02:42:54 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:71::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d77385a8esm199938eaf.11.2026.05.21.02.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 02:42:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 May 2026 02:42:50 -0700
Message-Id: <DIO99FYEHNC1.23KFEHRPTRB5N@gmail.com>
Subject: Re: [PATCH 2/8] bpf: Recover arena kernel faults with scratch page
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Tejun Heo" <tj@kernel.org>, "David Vernet" <void@manifault.com>,
 "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "David Hildenbrand"
 <david@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <sched-ext@lists.linux.dev>, <bpf@vger.kernel.org>,
 <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc
References: <20260520235052.4180316-1-tj@kernel.org>
 <20260520235052.4180316-3-tj@kernel.org>
In-Reply-To: <20260520235052.4180316-3-tj@kernel.org>

On Wed May 20, 2026 at 4:50 PM PDT, Tejun Heo wrote:
>
> v2: Use ptep_get_and_clear() in apply_range_clear_cb(). (David)
>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: David Hildenbrand <david@kernel.org>
> ---
>  Documentation/bpf/kfuncs.rst |  14 +++
>  arch/arm64/mm/fault.c        |  10 +-
>  arch/x86/mm/fault.c          |  12 ++-
>  include/linux/bpf.h          |   1 +
>  include/linux/bpf_defs.h     |  11 +++
>  kernel/bpf/arena.c           | 177 +++++++++++++++++++++++++++--------
>  kernel/bpf/core.c            |   5 +
>  7 files changed, 183 insertions(+), 47 deletions(-)
>  create mode 100644 include/linux/bpf_defs.h

First 5 patches lgtm. Should we create a stable branch out of them
and pull into bpf-next and sched-ext trees?
I'm preparing a followup for slab-over-arena on top of these changes.
