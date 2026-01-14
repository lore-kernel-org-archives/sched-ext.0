Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED573C38
	for <sched-ext@lists.linux.dev>; Wed, 14 Jan 2026 00:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768348999; cv=none; b=PiQoDeiB5no/CaPT1z9f+i9OntRYPC/KUV4SEEzL+qM16CPRD1nQkMtCiya8O5MghlbwRL+mpMJIl6h7f74/BXmpGuIMqMFLZja8AoBJBGdI7HA13sUl7/0S2UmXxCcgil7QbmSKsJEfEwJavMxi3nvZjkrC4OWswP84Hgxu1jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768348999; c=relaxed/simple;
	bh=heMMj6x6kDv01065lAemylYCNZI5UteaGBRwmdYTEcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JdZsrbSHPQkcqJY6vMiZs96OGnSWbACnmZ6vdA5+XEMYbuEAJCS9zghe112PxI9Hm/Ypbsm4XA1V2DVvhTQoVKYHgj2YKWfAwJPyTzrizYuarVB5jIhkusny3yt+cPRjGwHaUh/YAyqpJ9SI2W0+1b859Ascse7/xoMVWg4HEzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cnidCdYs; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cnidCdYs"
Message-ID: <aff8eeed-414c-49b3-b7f0-c8c328ed5199@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768348995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=don559aL9D0SVZWuW6XadPZv4mziJw23UN8eHPUOHTo=;
	b=cnidCdYsa7bBhhArI8AqYo/ZpxR7NwbXMYuaQc1ggGe7/JNYL7iQeslyqtNAcNQQjNsyNu
	GFqguzICZp/P1upH7vBCA5YHA1oFK2yxbeXwWCx1e5zeGoPcPNnYtIFP8x/181F1YIYm7o
	SJYd4JwtfdXuasuLB8RqMGrZ3+tSl5k=
Date: Tue, 13 Jan 2026 16:03:01 -0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 03/10] bpf: Verifier support for
 KF_IMPLICIT_ARGS
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, sched-ext@lists.linux.dev
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
 <20260109184852.1089786-4-ihor.solodrai@linux.dev>
 <18d9b15319bf8d71a3cd5b08239529505714dc96.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <18d9b15319bf8d71a3cd5b08239529505714dc96.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/13/26 1:59 PM, Eduard Zingerman wrote:
> On Fri, 2026-01-09 at 10:48 -0800, Ihor Solodrai wrote:
> 
> [...]
> 
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -3271,6 +3271,38 @@ static struct btf *find_kfunc_desc_btf(struct bpf_verifier_env *env, s16 offset)
>>  	return btf_vmlinux ?: ERR_PTR(-ENOENT);
>>  }
>>  
>> +#define KF_IMPL_SUFFIX "_impl"
>> +
>> +static const struct btf_type *find_kfunc_impl_proto(struct bpf_verifier_env *env,
>> +						    struct btf *btf,
>> +						    const char *func_name)
>> +{
>> +	char impl_name[KSYM_SYMBOL_LEN];
> 
> Oh, as we discussed already, this should use env->tmp_str_buf.

The env->tmp_str_buf size is smaller:

	#define TMP_STR_BUF_LEN 320

*And* there is already a local char buffer of size KSYM_SYMBOL_LEN
already in use in verifier.c:

	int bpf_check_attach_target(...) {
		bool prog_extension = prog->type == BPF_PROG_TYPE_EXT;
		bool prog_tracing = prog->type == BPF_PROG_TYPE_TRACING;
		char trace_symbol[KSYM_SYMBOL_LEN];
	[...]

Since these are function names, the real limit is KSYM_SYMBOL_LEN,
right?

Sure >320 chars long kfunc name is unlikely, but technically possible.

> 
>> +	const struct btf_type *func;
>> +	s32 impl_id;
>> +	int len;
>> +
>> +	len = snprintf(impl_name, sizeof(impl_name), "%s%s", func_name, KF_IMPL_SUFFIX);
>> +	if (len < 0 || len >= sizeof(impl_name)) {
>> +		verbose(env, "function name %s%s is too long\n", func_name, KF_IMPL_SUFFIX);
>> +		return NULL;
>> +	}
> 
> [...]

